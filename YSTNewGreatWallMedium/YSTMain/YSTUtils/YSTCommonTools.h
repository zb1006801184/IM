//
//  YSTCommonTools.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/21.
//  Copyright © 2017年 zhubiao. All rights reserved.
//  公用的方法类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//存用户信息标识
FOUNDATION_EXPORT NSString *const userDefault_UserModel;

@interface YSTCommonTools : NSObject
+ (UIViewController *)getCurrentVC;
+ (NSData *)replaceNoUtf8:(NSData *)data;
+ (NSData*)NeedJsonString:(NSString*)jsonStirng ;
+ (NSString *)changeDate:(NSString *)times :(NSString *)dateStyle;
@end
