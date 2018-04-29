//
//  MFNestTableView.h
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IPHONE_X (MAX(CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds])) == 812.0f)

@class MFNestTableView;

@protocol MFNestTableViewDelegate <NSObject>

@required
- (void)nestTableViewContentCanScroll:(MFNestTableView *)nestTableView;
- (void)nestTableViewContainerCanScroll:(MFNestTableView *)nestTableView;
- (void)nestTableViewDidScroll:(UIScrollView *)scrollView;

@end

@protocol MFNestTableViewDataSource <NSObject>

@optional
- (CGFloat)nestTableViewContentInsetTop:(MFNestTableView *)nestTableView;
- (CGFloat)nestTableViewContentInsetBottom:(MFNestTableView *)nestTableView;

@end

@interface MFNestTableView : UIView

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) NSArray *allowGestureEventPassViews;
@property (nonatomic, weak) id<MFNestTableViewDelegate> delegate;
@property (nonatomic, weak) id<MFNestTableViewDataSource> dataSource;

- (CGFloat)heightForContainerCanScroll;

- (void)setFooterViewHidden:(BOOL)hidden;

- (void)setHeaderViewHeight:(CGFloat)height;

- (void)setSegmentViewHeight:(CGFloat)height;

@end
