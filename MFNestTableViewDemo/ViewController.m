//
//  ViewController.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFNestTableView.h"
#import "MFSegmentView.h"

#import "ViewController.h"

@interface ViewController () <MFNestTableViewDelegate>

@property (nonatomic, strong) MFNestTableView *nestTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) MFSegmentView *segmentView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self initLayout];
}

- (void)initLayout {

    [self initHeaderView];
    [self initSegmentView];
    [self initContentView];
    
    _nestTableView = [[MFNestTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - [self statusBarAndNavigationBarHeight])];
    _nestTableView.tableHeaderView = _headerView;
    _nestTableView.segmentView = _segmentView;
    _nestTableView.contentView = _contentView;
    
    [self.view addSubview:_nestTableView];
}

- (void)initHeaderView {
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), 200)];
    _headerView.backgroundColor = [UIColor orangeColor];
}

- (void)initSegmentView {
    
    _segmentView = [[MFSegmentView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), 40)];
    _segmentView.itemWidth = 60;
    _segmentView.itemFont = [UIFont systemFontOfSize:15];
    _segmentView.itemNormalColor = [UIColor greenColor];
    _segmentView.itemSelectColor = [UIColor purpleColor];
    _segmentView.bottomLineWidth = 40;
    _segmentView.bottomLineHeight = 2;
    _segmentView.itemList = @[@"综合", @"分类1", @"分类2", @"分类3", @"分类4", @"分类5", @"分类6"];
}

- (void)initContentView {
    
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    _contentView.backgroundColor = [UIColor blueColor];
}

- (CGFloat)statusBarAndNavigationBarHeight {
    
    return CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]) + CGRectGetHeight(self.navigationController.navigationBar.frame);
}

#pragma mark - MFNestTableViewDelegate

- (void)nestTableViewContentWillEnableScroll:(MFNestTableView *)nestTableView {
    
   
}

@end
