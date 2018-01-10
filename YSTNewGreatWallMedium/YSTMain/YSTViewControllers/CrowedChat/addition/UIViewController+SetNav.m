//
//  UIViewController+SetNav.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "UIViewController+SetNav.h"

@implementation UIViewController (SetNav)
- (void)initLeftBack {
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftButton setImage:[UIImage imageNamed:@"icon-return"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents: UIControlEventTouchUpInside];
}
- (void)initRightButton:(NSString *)title {
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [rightButton setTitleColor:[UIColor colorWithHex:0xFB3C3C] forState:UIControlStateNormal];
    [rightButton setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents: UIControlEventTouchUpInside];
}

- (void)leftButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonClick:(UIButton *)button {
    
}
@end
