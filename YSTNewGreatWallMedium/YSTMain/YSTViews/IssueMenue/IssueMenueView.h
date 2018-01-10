//
//  IssueMenueView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/28.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueMenueItem.h"
@class IssueMenueView;
@protocol SpringMenuDelegate <NSObject>
@optional
// 点击功能按钮
- (void)springMenu:(IssueMenueView *)menu didClickButtonWithIndex:(NSInteger)index;
//
//// 点击底部按钮
- (void)springMenu:(IssueMenueView *)menu didClickBottomActiveButton:(UIButton *)button;
@end

@protocol SpringMenuDataSource <NSObject>
@optional
// 返回背景颜色
- (UIView *)backgroundViewOfSpringMenu:(IssueMenueView *)menu;
//
//@required
//// 返回底部的按钮
- (UIButton *)buttonToChangeActiveForSpringMenu:(IssueMenueView *)menu;
@end

@interface IssueMenueView : UIView
@property (weak, nonatomic) id<SpringMenuDelegate> delegate;

@property (weak, nonatomic) id<SpringMenuDataSource> dataSource;

/** 存储按钮图片和描述文字 */
@property (strong, nonatomic) NSArray *items;

/** 按钮列数 */
@property (assign, nonatomic) NSInteger columns;

/** 按钮直径 */
@property (assign, nonatomic) CGFloat buttonDiameter;

/** 按钮文字颜色 */
@property (strong, nonatomic) UIColor *buttonTitleColor;

/** 按钮显示后，最底部的按钮，距离底部的距离 */
@property (assign, nonatomic) CGFloat spaceToBottom;

/** 允许点击背景隐藏 */
@property (assign, nonatomic, getter=isEnableTouchResignActive) BOOL enableTouchResignActive;

+ (instancetype)menu;

+ (instancetype)menuWithItems:(NSArray *)items;

- (void)becomeActive;

- (void)resignActive;
@end
