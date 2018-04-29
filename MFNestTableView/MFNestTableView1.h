//
//  MFNestTableView.h
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFNestTableView;

@protocol MFNestTableViewDelegate <NSObject>

- (void)nestTableViewContentWillEnableScroll:(MFNestTableView *)nestTableView;

@end

@interface MFNestTableView : UITableView

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, weak) id<MFNestTableViewDelegate> nestDelegate;

@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIView *contentView;

@end
