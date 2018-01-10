//
//  YSTIssueViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTIssueViewController.h"
#import "IssueMenueView.h"
@interface YSTIssueViewController ()<SpringMenuDelegate,SpringMenuDataSource>
@property (nonatomic, strong) IssueMenueView *menueView;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@end

@implementation YSTIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

- (void)initView {
    IssueMenueItem *item1 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"Headimg"] title:@"问答"];
    IssueMenueItem *item2 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"Headimg"] title:@"招人"];
    IssueMenueItem *item3 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"Headimg"] title:@"图文咨询"];
    IssueMenueItem *item4 = [IssueMenueItem itemWithImage:[UIImage imageNamed:@"Headimg"] title:@"红包"];
    NSArray *items = @[item1, item2, item3, item4];
    IssueMenueView *menueView = [IssueMenueView menuWithItems:items];
    // 按钮文字颜色
    menueView.buttonTitleColor = [UIColor blackColor];
    // 按钮行数
    menueView.columns = 3;
    // 最后一个按钮与底部的距离
    menueView.spaceToBottom = 100;
    // 按钮半径（只支持圆形图片，非圆形图片以宽度算）
    menueView.buttonDiameter = 75;
    // 允许点击隐藏menu
    menueView.enableTouchResignActive = YES;
    menueView.dataSource = self;
    menueView.delegate = self;
    [self.view addSubview:menueView];
    [menueView becomeActive];

}



#pragma mark TPCSpringMenuDelegate
- (void)springMenu:(IssueMenueView *)menu didClickBottomActiveButton:(UIButton *)button
{
    [self.menueView resignActive];
    [self hideMenue];
}


- (void)springMenu:(IssueMenueView *)menu didClickButtonWithIndex:(NSInteger)index
{
    NSLog(@"%ld", index);
}
#pragma mark TPCSpringMenuDataSource
- (UIButton *)buttonToChangeActiveForSpringMenu:(IssueMenueView *)menu
{
    return self.bottomButton;
}

- (UIView *)backgroundViewOfSpringMenu:(IssueMenueView *)menu
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
//    imageView.bounds = CGRectMake(0, 0, 154, 48);
//    imageView.center = CGPointMake(self.view.bounds.size.width * 0.5, 100);
//    [view addSubview:imageView];
    return view;
}

- (void)hideMenue {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
