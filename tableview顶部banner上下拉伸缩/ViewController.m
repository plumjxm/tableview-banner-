//
//  ViewController.m
//  tableview顶部banner上下拉伸缩
//
//  Created by plum on 17/9/9.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleScrollView.h"
#import "UIViewExt.h"
#import "MPTableHeadView.h"


@interface ViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate>

@property(nonatomic,weak)MPTableHeadView *tableheadView;

@property(nonatomic,weak)SDCycleScrollView *headView1;

@property(nonatomic,weak)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    [self initFindHeaderView];

    
    MPTableHeadView *tableHeadView = [[MPTableHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    self.tableheadView = tableHeadView;
    self.tableView.tableHeaderView = self.tableheadView;
    
    
    
}

#pragma mark - initFindHeaderView
- (void)initFindHeaderView{
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width,headH ) delegate:self placeholderImage:nil];
    cycleScrollView2.autoScrollTimeInterval = 5;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.headView1 = cycleScrollView2;
    [self.tableView addSubview:cycleScrollView2];
    
    NSMutableArray *imgArr = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        NSString *imgname = [NSString stringWithFormat:@"%d.jpg",i];
        [imgArr addObject:imgname];
    }
    
    cycleScrollView2.localizationImageNamesGroup = imgArr;
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    // MPFindHeaderViewModel *data = _bannerArr[index];
    
    
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offy = scrollView.contentOffset.y;
    
    if (offy < 0)
    {
        CGRect frame = self.headView1.frame;
        frame.origin.y = offy;
        frame.size.height = -offy + headH;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        self.headView1.frame = frame;
    }
    
   
    
}


@end
