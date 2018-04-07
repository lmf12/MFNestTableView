//
//  ViewController.m
//  MFNestTableViewDemo
//
//  Created by Lyman Li on 2018/4/6.
//  Copyright © 2018年 Lyman Li. All rights reserved.
//

#import "MFNestTableView.h"
#import "MFPageView.h"
#import "MFSegmentView.h"

#import "ViewController.h"

@interface ViewController () <MFNestTableViewDelegate, MFPageViewDataSource, MFPageViewDelegate, MFSegmentViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MFNestTableView *nestTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) MFSegmentView *segmentView;
@property (nonatomic, strong) MFPageView *contentView;

@property (nonatomic, strong) NSMutableArray <NSArray *> *dataSource;
@property (nonatomic, strong) NSMutableArray <UIView *> *viewList;

@property (nonatomic, assign) BOOL canContentScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self initDataSource];
    [self initLayout];
}

- (void)initDataSource {
    
    NSArray *pageDataCount = @[@2, @10, @30];
    
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < pageDataCount.count; ++i) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int j = 0; j < [pageDataCount[i] integerValue]; ++j) {
            [array addObject:[NSString stringWithFormat:@"page - %d - row - %d", i, j]];
        }
        [_dataSource addObject:array];
    }
    
    _viewList = [[NSMutableArray alloc] init];
    for (int i = 0; i < pageDataCount.count; ++i) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = i;
        [_viewList addObject:tableView];
    }
}

- (void)initLayout {

    [self initHeaderView];
    [self initSegmentView];
    [self initContentView];
    
    _nestTableView = [[MFNestTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - [self statusBarAndNavigationBarHeight])];
    _nestTableView.tableHeaderView = _headerView;
    _nestTableView.segmentView = _segmentView;
    _nestTableView.contentView = _contentView;
    _nestTableView.nestDelegate = self;
    
    [self.view addSubview:_nestTableView];
}

- (void)initHeaderView {
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), 200)];
    _headerView.backgroundColor = [UIColor orangeColor];
}

- (void)initSegmentView {
    
    _segmentView = [[MFSegmentView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), 40)];
    _segmentView.segmentDelegate = self;
    _segmentView.itemWidth = 60;
    _segmentView.itemFont = [UIFont systemFontOfSize:15];
    _segmentView.itemNormalColor = [UIColor greenColor];
    _segmentView.itemSelectColor = [UIColor purpleColor];
    _segmentView.bottomLineWidth = 40;
    _segmentView.bottomLineHeight = 2;
    _segmentView.itemList = @[@"综合", @"分类1", @"分类2", @"分类3", @"分类4", @"分类5", @"分类6", @"分类7", @"分类8", @"分类9"];
}

- (void)initContentView {
    
    _contentView = [[MFPageView alloc] initWithFrame:self.view.bounds];
    _contentView.pageDataSource = self;
    _contentView.pageDelegate = self;
}

- (CGFloat)statusBarAndNavigationBarHeight {
    
    return CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]) + CGRectGetHeight(self.navigationController.navigationBar.frame);
}

#pragma mark - MFSegmentViewDelegate

- (void)segmentView:(MFSegmentView *)segmentView didScrollToIndex:(NSUInteger)index {
    
}

- (void)segmentViewDidScroll:(MFSegmentView *)segmentView {
    
//    _nestTableView.scrollEnabled = NO;  // 当 SegmentView 左右滑动的时候，禁止 NestTableView 上下滑动
}

- (void)segmentViewDidEndScrolling:(MFSegmentView *)segmentView {
    
//    _nestTableView.scrollEnabled = YES;
}

#pragma mark - MFNestTableViewDelegate

- (void)nestTableViewContentWillEnableScroll:(MFNestTableView *)nestTableView {
    
    _canContentScroll = YES;
}

#pragma mark - MFPageViewDataSource & MFPageViewDelegate

- (NSUInteger)numberOfPagesInPageView:(MFPageView *)pageView {
    
    return [_viewList count];
}

- (UIView *)pageView:(MFPageView *)pageView pageAtIndex:(NSUInteger)index {
    
    return _viewList[index];
}

- (void)pageView:(MFPageView *)pageView didScrollToIndex:(NSUInteger)index {
    
}

- (void)pageViewDidScroll:(MFPageView *)pageView {
    
//    _nestTableView.scrollEnabled = NO;  // 当 PageView 左右滑动的时候，禁止 NestTableView 上下滑动
}

- (void)pageViewDidEndScrolling:(MFPageView *)pageView {
    
//    _nestTableView.scrollEnabled = YES;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSUInteger pageIndex = tableView.tag;
    return [_dataSource[pageIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSUInteger pageIndex = tableView.tag;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSource[pageIndex][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_canContentScroll) {
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointZero;
        _nestTableView.canScroll = YES;
        _canContentScroll = NO;
    }
    scrollView.showsVerticalScrollIndicator = _canContentScroll;
}

@end
