//
//  NSString+TL.h
//  LiveCircle
//
//  Created by tianliang on 15/7/16.
//  Copyright (c) 2015年 quanzikeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (TL)

/**
 *  计算label宽度
 */
-(CGFloat)contentWidthWithSize:(CGFloat)size height:(CGFloat)height;
/**
 *  计算label高度
 */
-(CGFloat)contentHeightWithSize:(CGFloat)size width:(CGFloat)width;
/**
 *  是否为电话号码
 */
-(BOOL)isTelphoneNum;
/**
 *  是否为固定电话号码
 */
-(BOOL)isphoneNum;
/**
 * 功能： 判断长度大于6位小于20位并是否同时包含且只有数字和字母
 */
-(BOOL)judgePassWordLegal;
/**
 *  是否为邮箱格式
 */
-(BOOL)isValidateEmail;
/**
 *  将url进行等比例缩放
 */
-(NSString *)urlToScaleWidth:(NSInteger) W Height :(NSInteger)H;


@end
