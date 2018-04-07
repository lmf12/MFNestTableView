//
//  MFPageView.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFPageViewCell.h"

#import "MFPageView.h"

static NSString * const kPageViewCellReuseIdentifier = @"MFPageViewCell";

@interface MFPageView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MFPageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - private methods

- (void)commonInit {
    
    self.transform = CGAffineTransformMakeRotation(-M_PI/2); // 逆时针旋转90度
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = YES;  // 设置分页
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.pageDataSource) {
        return [self.pageDataSource numberOfPagesInPageView:self];
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MFPageViewCell *page = [[MFPageViewCell alloc] init];
    page.selectionStyle = UITableViewCellSelectionStyleNone;
    page.transform = CGAffineTransformMakeRotation(M_PI/2); // 顺时针旋转90度
    
    if (self.pageDataSource) {
        [page addSubview:[self.pageDataSource pageView:self pageAtIndex:indexPath.row]];
    }
    
    return page;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGRectGetHeight(self.bounds);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(pageViewDidScroll:)]) {
        [self.pageDelegate pageViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(pageViewDidEndScrolling:)]) {
        [self.pageDelegate pageViewDidEndScrolling:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(pageViewDidEndScrolling:)]) {
        [self.pageDelegate pageViewDidEndScrolling:self];
    }
}

@end
