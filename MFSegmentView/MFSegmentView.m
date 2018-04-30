//
//  MFSegmentView.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFSegmentViewCell.h"

#import "MFSegmentView.h"

static NSString * const kMFSegmentViewReuseIdentifier = @"MFSegmentViewReuseIdentifier";

@interface MFSegmentView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MFSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 调整所有item的尺寸，保证item高度和segmentView高度相等
    _collectionView.frame = [self bounds];
    _collectionViewLayout.itemSize = CGSizeMake(_itemWidth, CGRectGetHeight(self.frame));
    
    [_collectionView reloadData];
}

#pragma mark - setter

- (void)setItemList:(NSArray<NSString *> *)itemList {
    
    _itemList = itemList;
    [_collectionView reloadData];
}

- (void)setItemFont:(UIFont *)itemFont {
    
    _itemFont = itemFont;
    [_collectionView reloadData];
}

- (void)setItemWidth:(CGFloat)itemWidth {
    
    _itemWidth = itemWidth;
    [_collectionView reloadData];
}

- (void)setItemNormalColor:(UIColor *)itemNormalColor {
    
    _itemNormalColor = itemNormalColor;
    [_collectionView reloadData];
}

- (void)setItemSelectColor:(UIColor *)itemSelectColor {
    
    _itemSelectColor = itemSelectColor;
    [_collectionView reloadData];
}

#pragma mark - public methods

- (void)scrollToIndex:(NSUInteger)index {
    
    if (_currentIndex == index) {
        return;
    }
    if (index >= _itemList.count) {
        return;
    }
    
    [self selectIndex:[NSIndexPath indexPathForRow:index inSection:0]];
}

#pragma mark - private methods

- (void)commonInit {
    
    [self createCollectionViewLayout];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:[self bounds] collectionViewLayout:_collectionViewLayout];
    [self addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[MFSegmentViewCell class] forCellWithReuseIdentifier:kMFSegmentViewReuseIdentifier];
}

- (void)createCollectionViewLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    //设置item尺寸
    CGFloat itemW = _itemWidth;
    CGFloat itemH = CGRectGetHeight(self.frame);
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置水平滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionViewLayout = flowLayout;
}

- (void)selectIndex:(NSIndexPath *)indexPath {
    
    _currentIndex = indexPath.row;
    [_collectionView reloadData];
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didScrollToIndex:)]) {
        [self.delegate segmentView:self didScrollToIndex:indexPath.row];
    }
}


#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _itemList ? [_itemList count] : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MFSegmentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMFSegmentViewReuseIdentifier forIndexPath:indexPath];

    // 配置样式
    UILabel *label = cell.titleLabel;
    label.text = _itemList[indexPath.row];
    label.font = _itemFont;
    label.textColor = _currentIndex == indexPath.row ? _itemSelectColor : _itemNormalColor;
    
    UIView *bottomLine = cell.bottomLine;
    if (_currentIndex == indexPath.row) {
        bottomLine.hidden = NO;
        bottomLine.backgroundColor = _itemSelectColor;
        
        CGRect frame = bottomLine.frame;
        frame.size.width = _bottomLineWidth ? _bottomLineWidth : _itemWidth;
        frame.size.height = _bottomLineHeight ? _bottomLineHeight : CGRectGetHeight(frame);
        bottomLine.frame = frame;
        
        bottomLine.layer.cornerRadius = CGRectGetHeight(frame) / 2;
    } else {
        bottomLine.hidden = YES;
    }

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self selectIndex:indexPath];
}

@end
