//
//  MFPageViewCell.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFPageViewCell.h"

@implementation MFPageViewCell

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    frame.size.width = CGRectGetWidth(self.superview.bounds);
    self.frame = frame;
    
    for (UIView *view in self.subviews) {
        CGRect frame = view.frame;
        frame.origin = CGPointZero;
        frame.size = self.bounds.size;
        view.frame = frame;
    }
}

@end
