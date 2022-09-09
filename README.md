# MFNestTableView

这是一种多级 ScrollView 互相嵌套的实现方案，具体实现的效果看下面。

![](https://lymanli-1258009115.cos.ap-guangzhou.myqcloud.com/image/github/MFNestTableView/image1.gif)

## 适用范围

**屏幕方向**：竖屏  
**布局方式**：frame  
**机型**：iPhone（包括 iPhone X）& iPad

## 如何导入

#### 手动导入

将 MFNestTableView 文件夹、 MFPageView 文件夹（可选）、 MFSegmentView 文件夹（可选）、 MFTransparentNavigationBar 文件夹（可选）拖入工程中。

`
本项目做到了尽可能的解耦，除了 MFNestTableView 以外，其他控件可以自由组合，也可以加入本项目之外的其他控件。
`

## 布局方式

首先来参照下面的图片，看看每个控件对应的是哪个部分。

![](https://lymanli-1258009115.cos.ap-guangzhou.myqcloud.com/image/github/MFNestTableView/image2.jpg)

## 如何使用

### MFNestTableView

#### 1. 初始化

```objc
_nestTableView = [[MFNestTableView alloc] initWithFrame:self.view.bounds];
_nestTableView.headerView = _headerView;
_nestTableView.segmentView = _segmentView;
_nestTableView.contentView = _contentView;
_nestTableView.footerView = _footerView;
_nestTableView.allowGestureEventPassViews = _viewList;
_nestTableView.delegate = self;
_nestTableView.dataSource = self;
```

#### 2. 实现协议

在 ViewController 中实现协议 `MFNestTableViewDelegate` & `MFNestTableViewDataSource` 。

#### 3. 实现 `nestTableViewContentCanScroll:` 方法

在这里设置内容可以滚动：

```objc
- (void)nestTableViewContentCanScroll:(MFNestTableView *)nestTableView {
    
    self.canContentScroll = YES;
}
```

#### 4. 监听 `scrollViewDidScroll:` 方法

监听 ContentView 中所有 Scrollview 的 `scrollViewDidScroll:` 方法，并在正确的时机设置 Content 不能滚动、设置 Contianer 可以滚动：

```objc
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_canContentScroll) {
        // 这里通过固定contentOffset，来实现不滚动
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        _canContentScroll = NO;
        // 通知容器可以开始滚动
        _nestTableView.canScroll = YES;
    }
    scrollView.showsVerticalScrollIndicator = _canContentScroll;
}
```

#### 5. 实现 `nestTableViewContainerCanScroll:` 方法

在这里把 ContentView 每个 ScrollView 的 contentOffset 设置为 `CGPointZero`：

```objc
- (void)nestTableViewContainerCanScroll:(MFNestTableView *)nestTableView {
 
    // 当容器开始可以滚动时，将所有内容设置回到顶部
    for (id view in self.viewList) {
        UIScrollView *scrollView;
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = view;
        } else if ([view isKindOfClass:[UIWebView class]]) {
            scrollView = ((UIWebView *)view).scrollView;
        }
        if (scrollView) {
            scrollView.contentOffset = CGPointZero;
        }
    }
}
```

#### 6. （可选）实现 `nestTableViewContentInsetTop:` 方法

若当前 `navigationBar.translucent == YES` ，则需要实现 `nestTableViewContentInsetTop:` 方法，并返回下面的值：

```objc
- (CGFloat)nestTableViewContentInsetTop:(MFNestTableView *)nestTableView {
    
    // 因为这里navigationBar.translucent == YES，所以实现这个方法，返回下面的值
    if (IS_IPHONE_X) {
        return 88;
    } else {
        return 64;
    }
}
```

### MFSegmentView

#### 1. 初始化

```objc
_segmentView = [[MFSegmentView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
_segmentView.delegate = self;
_segmentView.itemWidth = 80;
_segmentView.itemFont = [UIFont systemFontOfSize:15];
_segmentView.itemNormalColor = [UIColor colorWithRed:155.0 / 255 green:155.0 / 255 blue:155.0 / 255 alpha:1];
_segmentView.itemSelectColor = [UIColor colorWithRed:244.0 / 255 green:67.0 / 255 blue:54.0 / 255 alpha:1];
_segmentView.bottomLineWidth = 60;
_segmentView.bottomLineHeight = 2;
_segmentView.itemList = @[@"列表1", @"列表2", @"列表3", @"图片", @"网页"];
```

#### 2. 实现协议

在 ViewController 中实现协议 `MFSegmentViewDelegate`。

#### 3. 实现方法

实现 `segmentView: didScrollToIndex:` 方法，可以监听 SegmentView 切换 Index 后的回调。

### MFPageView

#### 1. 初始化

```objc
_contentView = [[MFPageView alloc] initWithFrame:self.view.bounds];
_contentView.delegate = self;
_contentView.dataSource = self;
```

#### 2. 实现协议

在 ViewController 中实现协议 `MFPageViewDataSource` & `MFPageViewDelegate` 。

#### 3. 实现方法

1. 实现 `numberOfPagesInPageView:` 方法，返回总 Page 数。
2. 实现 `pageView: pageAtIndex:` 方法，返回每个 Index 对应的 View。
3. 实现 `pageView: didScrollToIndex:` 方法，可以监听 PageView 切换 Index 后的回调。


### MFTransparentNavigationBar


#### 1. 将 NavigationBar 的类型设置为 `MFTransparentNavigationBar`

1. 通过 `initWithNavigationBarClass: toolbarClass:` 来设置。
2. 在 xib 中设置。

#### 2. 设置 `MFTransparentBarButtonItem`

为 `MFTransparentBarButtonItem` 添加 `viewNormal` 和 `viewSelected` ，并将 `MFTransparentBarButtonItem` 添加到 `MFTransparentNavigationBar` 中。

#### 3. 设置透明度 

调用 `setBackgroundAlpha:` 来设置透明度。当 Alpha 小于 `0.95` 时， Title 隐藏 ，显示 `viewNormal` ；当大于等于 `0.95` 时， Title 显示 ，显示 `viewSelected` 。
