//
//  MFTransparentNavigationBar.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFTransparentNavigationBar.h"

@interface MFTransparentNavigationBar ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation MFTransparentNavigationBar

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

#pragma mark - Private methods

- (void)commonInit
{
    // 将原来的背景设置透明
    UIImage *transparentImage = [[UIImage alloc] init];
    [self setBackgroundImage:transparentImage forBarMetrics:UIBarMetricsDefault];
    
    // 去除分割线
    UIImage *shadowImage = [[UIImage alloc] init];
    [self setShadowImage:shadowImage];
}

- (void)setBackgroundAlpha:(CGFloat)alpha
{
    alpha = alpha > 1 ? 1 : alpha;
    alpha = alpha < 0 ? 0 : alpha;
    
    if (!_bgView) {
        CGFloat navigationBarHeight = CGRectGetHeight(self.bounds);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), navigationBarHeight)];
        self.bgView = view;view.backgroundColor = [UIColor redColor];
        self.bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [[[self subviews] firstObject] insertSubview:_bgView atIndex:0];
    }
    
    _bgView.backgroundColor = [UIColor colorWithWhite:1 alpha:alpha];
}

@end
