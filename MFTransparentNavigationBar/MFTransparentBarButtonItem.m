//
//  MFTransparentBarButtonItem.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/30.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFTransparentBarButtonItem.h"

@implementation MFTransparentBarButtonItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    self = [super initWithCustomView:view];
    return self;
}

- (void)setViewNormal:(UIView *)viewNormal {
    
    viewNormal.hidden = NO;
    viewNormal.frame = self.customView.bounds;
    _viewNormal = viewNormal;
    [self.customView addSubview:viewNormal];
}

- (void)setViewSelected:(UIView *)viewSelected {
    
    viewSelected.hidden = YES;
    viewSelected.frame = self.customView.bounds;
    _viewSelected = viewSelected;
    [self.customView addSubview:viewSelected];
}

- (void)setSelected:(BOOL)selected {
    
    if (!_viewNormal || !_viewSelected) {
        return;
    }
    _viewSelected.hidden = !selected;
    _viewNormal.hidden = selected;
}

@end
