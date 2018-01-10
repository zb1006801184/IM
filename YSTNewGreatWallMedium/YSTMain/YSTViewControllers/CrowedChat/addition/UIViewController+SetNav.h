//
//  UIViewController+SetNav.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SetNav)

/**
 导航栏返回按钮（固定样式）
 */
- (void)initLeftBack;

/**
 导航栏右侧按钮

 @param title 按钮标题
 */
- (void)initRightButton:(NSString *)title;

/**
 按钮的响应

 @param button 按钮
 */
- (void)rightButtonClick:(UIButton *)button;
@end
