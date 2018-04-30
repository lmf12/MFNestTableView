//
//  MFNestTableView.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFNestTableView.h"
#import "MFAllowGestureEventPassTableView.h"

@interface MFNestTableView () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) MFAllowGestureEventPassTableView *tableView;

@property (nonatomic, assign) BOOL isFooterViewHidden;

@end

@implementation MFNestTableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commomInit];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self resizeTableView];
}

#pragma mark - setter

- (void)setSegmentView:(UIView *)segmentView {
    
    if (_segmentView == segmentView) {
        return;
    }
    _segmentView = segmentView;
    
    [self resizeSegmentView];
    [_tableView reloadData];
}

- (void)setContentView:(UIView *)contentView {
    
    if (_contentView == contentView) {
        return;
    }
    _contentView = contentView;
    
    [self resizeContentHeight];
    [_tableView reloadData];
}

- (void)setHeaderView:(UIView *)headerView {
    
    if (_headerView == headerView) {
        return;
    }
    _headerView = headerView;
    if (_tableView) {
        _tableView.tableHeaderView = headerView;
    }
    
    [self resizeContentHeight];
    [_tableView reloadData];
}

- (void)setFooterView:(UIView *)footerView {
    
    if (_footerView == footerView) {
        return;
    }
    _footerView = footerView;
    
    [self resizeContentHeight];
    [_tableView reloadData];
}

- (void)setAllowGestureEventPassViews:(NSArray *)allowGestureEventPassViews {
    
    if (_tableView) {
        [_tableView setAllowGestureEventPassViews:allowGestureEventPassViews];
    }
}

- (void)setDataSource:(id<MFNestTableViewDataSource>)dataSource {
    
    if (_dataSource == dataSource) {
        return;
    }
    _dataSource = dataSource;
    
    [self resizeContentHeight];
    [_tableView reloadData];
}

- (void)setCanScroll:(BOOL)canScroll {
    
    if (_canScroll == canScroll) {
        return;
    }
    _canScroll = canScroll;
    
    if (canScroll && self.delegate && [self.delegate respondsToSelector:@selector(nestTableViewContainerCanScroll:)]) {
         // 通知delegate，容器开始可以滚动
        [self.delegate nestTableViewContainerCanScroll:self];
    }
}

#pragma mark - public methods

- (CGFloat)heightForContainerCanScroll {
    
    if (_tableView && _tableView.tableHeaderView) {
        return CGRectGetHeight(_tableView.tableHeaderView.frame) - [self contentInsetTop];
    } else {
        return 0;
    }
}

- (void)setFooterViewHidden:(BOOL)hidden {
    
    self.isFooterViewHidden = hidden;
    [self resizeContentHeight];
    
    [_tableView reloadData];
}

- (void)setHeaderViewHeight:(CGFloat)height {
    
    if (!_tableView || !_tableView.tableHeaderView) {
        return;
    }
    UIView *headerView = _tableView.tableHeaderView;
    CGRect frame = headerView.frame;
    frame.size.height = height;
    headerView.frame = frame;
    _tableView.tableHeaderView = headerView;  // 这里要将headerView重新赋值才能生效
    
    [self resizeContentHeight];
    [_tableView reloadData];
}

- (void)setSegmentViewHeight:(CGFloat)height {
    
    if (!_segmentView) {
        return;
    }
    CGRect frame = _segmentView.frame;
    frame.size.height = height;
    _segmentView.frame = frame;
    
    [self resizeContentHeight];
    [_tableView reloadData];
}

#pragma mark - private methods

- (void)commomInit {
    
    MFAllowGestureEventPassTableView *tableView = [[MFAllowGestureEventPassTableView alloc] initWithFrame:self.bounds];
    self.tableView = tableView;
    [self addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.canScroll = YES;
}

- (CGFloat)contentInsetTop {
    
    // 如果dataSource实现了这个方法，则返回dataSource重写的返回值，否则返回默认值
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(nestTableViewContentInsetTop:)]) {
        return [self.dataSource nestTableViewContentInsetTop:self];
    }
    
    return 0;
}

- (CGFloat)contentInsetBottom {
    
    // 如果dataSource实现了这个方法，则返回dataSource重写的返回值，否则返回默认值
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(nestTableViewContentInsetBottom:)]) {
        return [self.dataSource nestTableViewContentInsetBottom:self];
    }
    
    if (IS_IPHONE_X) {
        return 34;
    } else {
        return 0;
    }
}

- (CGFloat)segmentViewHeight {
    
    return _segmentView ? CGRectGetHeight(_segmentView.bounds) : 0;
}

- (CGFloat)footerViewHeight {
    
    return (_footerView && !_isFooterViewHidden) ? CGRectGetHeight(_footerView.bounds) : 0;
}

- (void)resizeContentHeight {
    
    if (!_contentView) {
        return;
    }
    
    CGFloat contentHeight = CGRectGetHeight(self.bounds) - [self segmentViewHeight] - [self contentInsetTop] - [self contentInsetBottom] - [self footerViewHeight];
    _contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), contentHeight);
}

- (void)resizeTableView {
    
    if (_tableView) {
        _tableView.frame = self.bounds;
    }
}

- (void)resizeSegmentView {
    
    if (_segmentView) {
        _segmentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(_segmentView.frame));
    }
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (_contentView) {
        UIView *view = cell.contentView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [view addSubview:_contentView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_contentView) {
        return 0;
    }
    
    return CGRectGetHeight(_contentView.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [self segmentViewHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_segmentView) {
        return _segmentView;
    } else {
        return [[UIView alloc] init];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (_footerView && !_isFooterViewHidden) {
        return _footerView;
    } else {
        return [[UIView alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return [self footerViewHeight];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = [self heightForContainerCanScroll];
    
    if (!_canScroll) {
        // 这里通过固定contentOffset的值，来实现不滚动
        scrollView.contentOffset = CGPointMake(0, contentOffset);
    } else if (scrollView.contentOffset.y >= contentOffset) {
        scrollView.contentOffset = CGPointMake(0, contentOffset);
        self.canScroll = NO;
        
        // 通知delegate内容开始可以滚动
        if (self.delegate && [self.delegate respondsToSelector:@selector(nestTableViewContentCanScroll:)]) {
            [self.delegate nestTableViewContentCanScroll:self];
        }
    }
    scrollView.showsVerticalScrollIndicator = _canScroll;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(nestTableViewDidScroll:)]) {
        [self.delegate nestTableViewDidScroll:_tableView];
    }
}

@end
