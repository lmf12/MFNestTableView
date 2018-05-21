//
//  MFAllowGestureEventPassTableView.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFAllowGestureEventPassTableView.h"

@interface MFAllowGestureEventPassTableView () <UIGestureRecognizerDelegate>

@end

@implementation MFAllowGestureEventPassTableView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - private methods

- (void) commonInit {
    // 在某些情况下，contentView中的点击事件会被panGestureRecognizer拦截，导致不能响应，
    // 这里设置cancelsTouchesInView表示不拦截
    self.panGestureRecognizer.cancelsTouchesInView = NO;
}

#pragma mark - UIGestureRecognizerDelegate

// 返回YES表示可以继续传递触摸事件，这样两个嵌套的scrollView才能同时滚动
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    id view = otherGestureRecognizer.view;
    if ([[view superview] isKindOfClass:[UIWebView class]]) {
        view = [view superview];
    }
    
    if (_allowGestureEventPassViews && [_allowGestureEventPassViews containsObject:view]) {
        return YES;
    } else {
        return NO;
    }
}

@end
