//
//  MFPageView.h
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFPageView;

@protocol MFPageViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInPageView:(MFPageView *)pageView;
- (UIView *)pageView:(MFPageView *)pageView pageAtIndex:(NSUInteger)index;

@end

@protocol MFPageViewDelegate <NSObject>

- (void)pageView:(MFPageView *)pageView didScrollToIndex:(NSUInteger)index;
- (void)pageViewDidScroll:(MFPageView *)pageView;
- (void)pageViewDidEndScrolling:(MFPageView *)pageView;

@end

@interface MFPageView : UITableView

@property (nonatomic, assign) id<MFPageViewDelegate> pageDelegate;
@property (nonatomic, assign) id<MFPageViewDataSource> pageDataSource;

@end
