//
//  YSTTabBarViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/22.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTTabBarViewController.h"
#import "NewsViewController.h"
#import "YSTHomeViewController.h"
#import "YSTLiveViewController.h"
#import "YSTIssueViewController.h"
#import "YSTFamousViewController.h"
#import "YSTMineViewController.h"
#import "YSTSocketTool.h"
#import "CrowedChatViewController.h"
#import "LBTabBar.h"

@interface YSTTabBarViewController ()<LBTabBarDelegate,UITabBarControllerDelegate>

@end
@implementation YSTTabBarViewController


#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor blackColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor redColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
//    [self setValue:tabbar forKeyPath:@"tabBar"];
    
}

- (void)presentCenterView {
    YSTIssueViewController *IssueVC = [[YSTIssueViewController alloc]init];
    [self presentViewController:IssueVC animated:YES completion:nil];
}

- (void)centerIssueButton {
    //发布
    UIButton *centerButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 0, 70, kTabbarHeight)];
    centerButton.backgroundColor = [UIColor clearColor];
    [centerButton addTarget:self action:@selector(centerIssueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:centerButton];
}
- (void)centerIssueButtonClick:(UIButton *)button {
    NSLog(@"发布发布");
}



#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    
    
    NewsViewController *homeVC = [[NewsViewController alloc]init];
    homeVC.type = 1;
    [self setUpOneChildVcWithVc:homeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"消息"];
    
//    YSTLiveViewController *liveVC = [[YSTLiveViewController alloc]init];
//    [self setUpOneChildVcWithVc:liveVC Image:@"fish_normal" selectedImage:@"fish_highlight" title:@"视频"];
    CrowedChatViewController *crowedVC = [[CrowedChatViewController alloc]init];
    [self setUpOneChildVcWithVc:crowedVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"群聊"];
    NewsViewController *famousVC = [[NewsViewController alloc]init];
    famousVC.type = 2;
    [self setUpOneChildVcWithVc:famousVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"好友"];
    
    YSTMineViewController *mineVC = [[YSTMineViewController alloc]init];
    [self setUpOneChildVcWithVc:mineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
    
 
    
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
//    Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
    
}




#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
    
    [self presentCenterView];
    
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    

}



@end
