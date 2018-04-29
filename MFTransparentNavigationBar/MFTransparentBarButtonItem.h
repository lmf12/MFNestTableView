//
//  MFTransparentBarButtonItem.h
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/30.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFTransparentBarButtonItem : UIBarButtonItem

@property (nonatomic, strong) UIView *viewNormal;
@property (nonatomic, strong) UIView *viewSelected;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithFrame:(CGRect)frame;

@end
