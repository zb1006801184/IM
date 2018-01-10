//
//  Constant.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/21.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#define rColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//    系统控件默认高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define kStateHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44) //导航栏+状态栏高度
#define kTabbarHeight  (([[UIApplication sharedApplication] statusBarFrame].size.height) > (20) ? 83 : 49 ) //底部tabbar高度

#define WS(weakSelf) __weak typeof(self) weakSelf = self;




#endif /* Constant_h */
