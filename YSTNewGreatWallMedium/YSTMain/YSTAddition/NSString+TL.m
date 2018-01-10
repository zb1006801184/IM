//
//  NSString+TL.m
//  LiveCircle
//
//  Created by tianliang on 15/7/16.
//  Copyright (c) 2015年 quanzikeji. All rights reserved.
//

#import "NSString+TL.h"
@implementation NSString (TL)

-(CGFloat)contentHeightWithSize:(CGFloat)size width:(CGFloat)width{
//    第一个参数：是进行自适应的尺寸  第二个参数：布局格式 第三个参数：字符串的属性列表  第四个忽略
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 0) options:
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
        return rect.size.height;
    

}

-(CGFloat)contentWidthWithSize:(CGFloat)size height:(CGFloat)height{
    //第一个参数：是进行自适应的尺寸  第二个参数：布局格式 第三个参数：字符串的属性列表  第四个忽略
        CGRect rect = [self boundingRectWithSize:CGSizeMake(0, height) options:
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
        return rect.size.width;

}

/**
 * 功能： 判断长度大于6位小于20位并是否同时包含且只有数字和字母
 */
-(BOOL)judgePassWordLegal{
    
    NSString *Regex = @"\\w{6,16}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [emailTest evaluateWithObject:self];
}

//利用正则表达式验证邮箱格式是否正确
-(BOOL)isValidateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)isTelphoneNum{
    
    NSString *telRegex = @"^1[3578]\\d{9}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self];
}
//判断固定电话
-(BOOL)isphoneNum{
    
    NSString *telRegex = @"^(0[0-9]{2,3}/-)?([2-9][0-9]{6,7})+(/-[0-9]{1,4})?$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self];
}

-(NSString *)urlToScaleWidth:(NSInteger) W Height :(NSInteger) H{
    NSString *scaleUrl = [NSString stringWithFormat:@"%@?imageView2/1/w/%li/h/%li",self,W,H];
    return scaleUrl;
}

@end
