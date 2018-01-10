//
//  GJEmoManage.h
//  GJKeyboard
///
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, PlistType) {
    NSArrayType = 0,  //数组类型
    NSDictionaryType //字典类型
};


@interface GJEmoManage : NSObject

+ (NSMutableDictionary *)emotionManage:(NSString *)plistPath plistType:(NSInteger)type itemCount:(int)count;

@end
