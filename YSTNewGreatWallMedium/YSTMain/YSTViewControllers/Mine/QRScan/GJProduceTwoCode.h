//
//  GJProduceTwoCode.h
//  二维码
//
//  Created by 郭杰 on 2017/12/4.
//  Copyright © 2017年 郭杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GJProduceTwoCode : NSObject


/**
 创建二维码
 参数1：二维码目标字符串
 参数2：指定生成的大小size - 建议size的大小传imageView的大小
 参数3：添加的logo（可以为nil） - 其中logo的大小为size的5.0（默认， 也可以去修改pro）
 */
+ (UIImage *)codeWidthDataString:(NSString *)TargetString size:(CGFloat)size logo:(NSString *)logoName;

@end
