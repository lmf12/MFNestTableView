//
//  MFSegmentView.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFSegmentViewCell.h"

#import "MFSegmentView.h"

static NSString * const kSegmentViewCellReuseIdentifier = @"MFSegmentViewCell";

@interface MFSegmentView () <UITableViewDelegate, UITableViewDataSource>

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

#pragma mark - public methods

- (void)scrollToIndex:(NSUInteger)index {
    
    [self selectIndex:[[NSIndexPath alloc] initWithIndex:index]];
}

#pragma mark - setter

- (void)setItemList:(NSArray<NSString *> *)itemList {
    
    _itemList = itemList;
    [self reloadData];
}

- (void)setItemFont:(UIFont *)itemFont {
    
    _itemFont = itemFont;
    [self reloadData];
}

- (void)setItemWidth:(CGFloat)itemWidth {
    
    _itemWidth = itemWidth;
    [self reloadData];
}

- (void)setItemNormalColor:(UIColor *)itemNormalColor {
    
    _itemNormalColor = itemNormalColor;
    [self reloadData];
}

- (void)setItemSelectColor:(UIColor *)itemSelectColor {
    
    _itemSelectColor = itemSelectColor;
    [self reloadData];
}

#pragma mark - private methods

- (void)commonInit {
    
    _currentIndex = 0;
    _itemFont = [UIFont systemFontOfSize:17];
    _itemNormalColor = [UIColor grayColor];
    _itemSelectColor = [UIColor redColor];
    
    self.transform = CGAffineTransformMakeRotation(-M_PI/2); // 逆时针旋转90度
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[MFSegmentViewCell class] forCellReuseIdentifier:kSegmentViewCellReuseIdentifier];
}

- (void)selectIndex:(NSIndexPath *)indexPath {
    
    _currentIndex = indexPath.row;
    [self reloadData];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(segmentView:didScrollToIndex:)]) {
        [self.segmentDelegate segmentView:self didScrollToIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _itemList ? _itemList.count : 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MFSegmentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSegmentViewCellReuseIdentifier];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.transform = CGAffineTransformMakeRotation(M_PI/2); // 顺时针旋转90度
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _itemWidth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self selectIndex:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(segmentViewDidScroll:)]) {
        [self.segmentDelegate segmentViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(segmentViewDidEndScrolling:)]) {
        [self.segmentDelegate segmentViewDidEndScrolling:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(segmentViewDidEndScrolling:)]) {
        [self.segmentDelegate segmentViewDidEndScrolling:self];
    }
}

@end
