//
//  YSTHomeViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTHomeViewController.h"
#import "SGPageTitleView.h"
#import "SGPageTitleViewConfigure.h"
#import "HomeSegmentView.h"
#import "YSTSocketTool.h"
@interface YSTHomeViewController ()<UIScrollViewDelegate,SGPageTitleViewDelegate>

#define XTSegmentControlhight 40//标签的高度

@property(retain ,nonatomic)UIScrollView *scrollView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) NSArray *titleList;//标签数组


/// 记录刚开始时的偏移量
@property (nonatomic, assign) NSInteger startOffsetX;



@end

@implementation YSTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    YSTSocketTool *socketTool = [YSTSocketTool ShareSocketTool];
    [socketTool startConnect];
    [self xtsegmentControl];
}

-(void)xtsegmentControl{
    
    _titleList = @[@"关注",@"名人",@"北京",@"问答",@"数码",@"科技",@"财经"];
    
    //    背景滚动视图
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(kScreenWidth*_titleList.count,0)];
    self.scrollView.frame=CGRectMake(0, kNavHeight+XTSegmentControlhight, kScreenWidth, kScreenHeight-kNavHeight-kTabbarHeight-XTSegmentControlhight);
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;//是否翻页
    _scrollView.bounces = NO;
    [_scrollView setContentOffset:CGPointMake(0, 0)];

    
    //    标签视图
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor blackColor];
    configure.titleSelectedColor = [UIColor redColor];
    configure.indicatorColor = [UIColor redColor];
    configure.spacingBetweenButtons = 30;
    configure.titleFont = [UIFont systemFontOfSize:16];
    //    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度


    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(10, kNavHeight, kScreenWidth-20, XTSegmentControlhight) delegate:self titleNames:_titleList configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isShowBottomSeparator = NO;//是否显示底部的线
    _pageTitleView.isOpenTitleTextZoom = YES;//开启文字缩放
    _pageTitleView.titleTextScaling = .25;
//    _pageTitleView.selectedIndex = 0;
    
    //    滑动视图上面对应的view
    [_titleList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            HomeSegmentView *listview = [[HomeSegmentView alloc]initWithFrame:CGRectMake(kScreenWidth*idx, 0, kScreenWidth, _scrollView.height)];
            [_scrollView addSubview:listview];
            listview.tag = 100+idx;
        }
        
    }];
}

#pragma mark - SGPageTitleViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [_scrollView setContentOffset:CGPointMake(selectedIndex*kScreenWidth, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.startOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 1、定义获取需要的数据
    CGFloat progress = 0;
    NSInteger originalIndex = 0;
    NSInteger targetIndex = 0;
    // 2、判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > self.startOffsetX) { // 左滑
        // 1、计算 progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        // 2、计算 originalIndex
        originalIndex = currentOffsetX / scrollViewW;
        // 3、计算 targetIndex
        targetIndex = originalIndex + 1;
        if (targetIndex >= self.titleList.count) {
            progress = 1;
            targetIndex = originalIndex;
        }
        // 4、如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = originalIndex;
        }
    } else { // 右滑
        // 1、计算 progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        // 2、计算 targetIndex
        targetIndex = currentOffsetX / scrollViewW;
        // 3、计算 originalIndex
        originalIndex = targetIndex + 1;
        if (originalIndex >= self.titleList.count) {
            originalIndex = self.titleList.count - 1;
        }
    }
    
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    
}


@end

