//
//  UIColor+TL.h
//  LiveCircle
//
//  Created by tianliang on 15/8/26.
//  Copyright (c) 2015年 quanzikeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TL)
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;
@end
