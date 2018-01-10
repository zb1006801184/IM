//
//  YSTCommonTools.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/21.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTCommonTools.h"
NSString *const  userDefault_UserModel = @"userModel";


@implementation YSTCommonTools
+ (UIViewController *)getCurrentVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

+ (NSData *)replaceNoUtf8:(NSData *)data
{
    char aa[] = {'A','A','A','A','A','A'};                      //utf8最多6个字符，当前方法未使用
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length])
    {
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0)
        {
            loc++;
            continue;
        }
        else if((buffer & 0xE0) == 0xC0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                continue;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else if((buffer & 0xF0) == 0xE0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80)
                {
                    loc++;
                    continue;
                }
                loc--;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else
        {
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    
    return md;
}

+ (NSData*)NeedJsonString:(NSString*)jsonStirng {
    
    NSData*data1 = [jsonStirng dataUsingEncoding:NSUTF8StringEncoding];
    
#if __LP64__ || NS_BUILD_32_LIKE_64
    
    //long sendSuccess;
    
    NSInteger bits = [data1 length];
    
#else
    
    //int sendSuccess;
    
    int bits = [data1 length];
    
#endif
    
    short bit = bits;
    
    NSData*data2 = [NSData dataWithBytes:&bit length:sizeof(bit)];//低位高位
    
    Byte*testByte = (Byte*)[data2 bytes];
    
    /**
     
     *修改byte高地位--适应安卓
     
     */
    
    int one = testByte[0];
    
    testByte[0] = testByte[1];
    
    testByte[1] = one;
    
    NSData*data3 = [[NSData alloc]initWithBytes:testByte length:2];
    
    NSMutableData*mutableData = [[NSMutableData alloc]initWithData:data3];//先把长度加上
    
    [mutableData appendData:data1];//要发出的数据
    
    return mutableData;
    
}

+ (NSString *)changeDate:(NSString *)times :(NSString *)dateStyle
{
    
    NSTimeInterval time = [times floatValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateStyle];
    NSString *currentDateStr = [dateFormatter stringFromDate:confromTimesp];
    return currentDateStr;
}


@end
