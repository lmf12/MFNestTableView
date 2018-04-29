//
//  MFNestTableView.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFNestTableView.h"

@interface MFNestTableView () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@end

@implementation MFNestTableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - setter

- (void)setSegmentView:(UIView *)segmentView {
    
    _segmentView = segmentView;
    
    [self reloadData];
}

- (void)setContentView:(UIView *)contentView {
    
    contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - [self segmentViewHeight]);
    _contentView = contentView;
    
    [self reloadData];
}

#pragma mark - private methods

- (void)commonInit {
    
    self.delegate = self;
    self.dataSource = self;
    self.canScroll = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)segmentViewHeight {
    
    return _segmentView ? CGRectGetHeight(_segmentView.bounds) : 0.5f;
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
        [view addSubview:_contentView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGRectGetHeight(self.bounds) - [self segmentViewHeight];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = [self rectForSection:0].origin.y;
    
    if (!_canScroll) {
        scrollView.contentOffset = CGPointMake(0, contentOffset);
    } else if (scrollView.contentOffset.y >= contentOffset) {
        scrollView.contentOffset = CGPointMake(0, contentOffset);
        _canScroll = NO;
        
        // 通知内容视图可以滚动
        if (self.nestDelegate && [self.nestDelegate respondsToSelector:@selector(nestTableViewContentWillEnableScroll:)]) {
            [self.nestDelegate nestTableViewContentWillEnableScroll:self];
        }
    }
    scrollView.showsVerticalScrollIndicator = _canScroll;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

@end
