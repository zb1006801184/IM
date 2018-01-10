//
//  YSTSocketTool.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/23.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
@protocol SocketDelegate <NSObject>

/**
 接收到消息的接口

 @param data 消息
 */
- (void)readDataWithMessage:(NSData *)data;

@end
@interface YSTSocketTool : NSObject
@property (nonatomic, weak) id <SocketDelegate>detegate;
@property (nonatomic, assign) BOOL connected;

+ (instancetype)ShareSocketTool;

/**
 socekt 开始连接
 */
- (void)startConnect;

/**
 发送文本消息

 @param text 消息内容
 */
- (void)sendMessage:(NSString *)text;

/**
 发送消息

 @param data 消息数据
 */
-  (void)sendMessageWithData:(NSData *)data;

@end
