//
//  TitleView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol titleViewDegetele <NSObject>

/**
 左侧按钮的点击

 @param button 按钮
 */
- (void)chatLeftClick:(UIButton *)button;

/**
 右侧按钮的点击

 @param button 按钮
 */
- (void)chatRightClick:(UIButton *)button;
@end
@interface TitleView : UIView
@property (nonatomic, weak)id <titleViewDegetele>degetele;
@property (nonatomic, strong) NSArray *titles;//标题数组
@property (nonatomic, strong) NSMutableArray *dataList;
@end
