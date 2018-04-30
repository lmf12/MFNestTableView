//
//  MFNestTableView.h
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IPHONE_X (MAX(CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds])) == 812.0f)

@class MFNestTableView;

@protocol MFNestTableViewDelegate <NSObject>

@required

// 当内容可以滚动时会调用
- (void)nestTableViewContentCanScroll:(MFNestTableView *)nestTableView;

// 当容器可以滚动时会调用
- (void)nestTableViewContainerCanScroll:(MFNestTableView *)nestTableView;

// 当容器正在滚动时调用，参数scrollView就是充当容器的tableView
- (void)nestTableViewDidScroll:(UIScrollView *)scrollView;

@end

@protocol MFNestTableViewDataSource <NSObject>

@optional

// 根据 navigationBar 是否透明，返回不同的值
// 1. 当设置 navigationBar.translucent = NO 时，
//    普通机型 InsetTop = 0， iPhoneX InsetTop = 0 （默认情况）
// 2. 当设置 navigationBar.translucent = YES 时，
//    普通机型 InsetTop = 64， iPhoneX InsetTop = 88
- (CGFloat)nestTableViewContentInsetTop:(MFNestTableView *)nestTableView;

// 一般不需要实现
// 普通机型 InsetBottom = 0， iPhoneX InsetBottom = 34 （默认情况）
- (CGFloat)nestTableViewContentInsetBottom:(MFNestTableView *)nestTableView;

@end

@interface MFNestTableView : UIView

// 头部
@property (nonatomic, strong) UIView *headerView;
// 分类导航
@property (nonatomic, strong) UIView *segmentView;
// 内容
@property (nonatomic, strong) UIView *contentView;
// 底部
@property (nonatomic, strong) UIView *footerView;

// 设置容器是否可以滚动
@property (nonatomic, assign) BOOL canScroll;
// 允许手势传递的view列表
@property (nonatomic, strong) NSArray *allowGestureEventPassViews;

@property (nonatomic, weak) id<MFNestTableViewDelegate> delegate;
@property (nonatomic, weak) id<MFNestTableViewDataSource> dataSource;

// 返回容器可以滑动的高度
// 超过这个高度，canScroll会设置为NO，并且会调用delegate中的nestTableViewContentCanScroll:
- (CGFloat)heightForContainerCanScroll;

// 设置底部的显示和隐藏，设置后会自动重新调整contentView的高度
- (void)setFooterViewHidden:(BOOL)hidden;

// 设置头部的高度，设置后会自动重新调整contentView的高度
- (void)setHeaderViewHeight:(CGFloat)height;

// 设置分类导航的高度，设置后会自动重新调整contentView的高度
- (void)setSegmentViewHeight:(CGFloat)height;

@end
