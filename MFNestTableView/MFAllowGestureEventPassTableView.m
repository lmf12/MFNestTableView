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

#pragma mark - UIGestureRecognizerDelegate

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
