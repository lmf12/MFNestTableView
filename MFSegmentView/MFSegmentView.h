//
//  MFSegmentView.h
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/29.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFSegmentView;

@protocol MFSegmentViewDelegate <NSObject>

- (void)segmentView:(MFSegmentView *)segmentView didScrollToIndex:(NSUInteger)index;

@end


@interface MFSegmentView : UIView

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, assign) CGFloat bottomLineWidth;
@property (nonatomic, assign) CGFloat bottomLineHeight;

@property (nonatomic, strong) NSArray <NSString *> *itemList;

@property (nonatomic, weak) id<MFSegmentViewDelegate> delegate;

- (void)scrollToIndex:(NSUInteger)index;

@end
