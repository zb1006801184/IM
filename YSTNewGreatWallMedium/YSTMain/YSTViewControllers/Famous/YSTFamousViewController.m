//
//  YSTFamousViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTFamousViewController.h"
#import "NewsViewController.h"
@interface YSTFamousViewController ()

@end

@implementation YSTFamousViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)chatClick:(id)sender {
    NewsViewController *newVC = [[NewsViewController alloc]init];
    newVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newVC animated:YES];

}


@end
