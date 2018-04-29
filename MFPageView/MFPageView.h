//
//  MFPageView.h
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
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

@end

@interface MFPageView : UIView

@property (nonatomic, weak) id<MFPageViewDataSource> dataSource;
@property (nonatomic, weak) id<MFPageViewDelegate> delegate;

- (void)scrollToIndex:(NSUInteger)index;

@end
