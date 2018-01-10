//
//  SingletonH.m
//  keyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import <Foundation/Foundation.h>
//.h文件
#define SingletonH  + (instancetype)sharedInstance;


//加上斜杠是为了让编辑器认为下一行代码也是宏的内容
//.m文件
#define SingletonM \
static id _instance;\
\
+ (instancetype)sharedInstance\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc]init];\
});\
return _instance;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}
