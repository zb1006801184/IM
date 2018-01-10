//
//  YSTSocketTool.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/23.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTSocketTool.h"
#import "UserModel.h"
@interface YSTSocketTool()<GCDAsyncSocketDelegate>
@property (strong, nonatomic) GCDAsyncSocket *clientSocket;
@property (nonatomic, strong) NSTimer *connectTimer;
@property (nonatomic, strong) NSTimer *againConnectTimer;
@end

@implementation YSTSocketTool
// single object mothed
+ (instancetype)ShareSocketTool {
    static YSTSocketTool *SocketTool = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        SocketTool = [[YSTSocketTool alloc] init];
    });
    return SocketTool;
}

// 添加计时器
- (void)addTimer
{
    // 长连接定时器
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}

//开始链接服务器
- (void)startConnect {
    // 链接服务器
    if (!self.connected)
    {
        self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSLog(@"开始连接%@",self.clientSocket);
        NSError *error = nil;
        self.connected = [self.clientSocket connectToHost:YST_API_URL onPort:[YST_API_PORT integerValue] viaInterface:nil withTimeout:-1 error:&error];
        
        if(self.connected)
        {
            NSLog(@"客户端尝试连接");
        }
        else
        {
            self.connected = NO;
            NSLog(@"客户端未创建连接");
//            // 重连服务器
//            [self againConnectToSocket];
        }
    }
    else
    {
        NSLog(@"与服务器连接已建立");

    }
}

// 心跳连接
- (void)longConnectToSocket
{
    UserModel *userModel = [UserModel getModel];
    if (userModel.userId.length < 1) {
        return;
    }
    NSDictionary *test = @{@"accepteId":@"-1",@"senderId":userModel.userId,@"content":@"to",@"event":@"2"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:test options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonStr = [NSString stringWithFormat:@"%lu    %@",(unsigned long)jsonStr.length,jsonStr];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}

// 重连
- (void)againConnectToSocket {
    // 重连定时器
    self.againConnectTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(startConnect) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.againConnectTimer forMode:NSRunLoopCommonModes];
}

- (void)sendMessage:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}
- (void)sendMessageWithData:(NSData *)data {
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接服务器成功：IP-%@，端口-%d",host,port);
    UserModel *userModel = [UserModel getModel];
    if (userModel.userId.length < 1) {
        return;
    }
    NSDictionary *test = @{@"accepteId":userModel.userId,@"senderId":userModel.userId,@"content":@"first",@"event":@"0"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:test options:NSJSONWritingPrettyPrinted error:nil];
    //        NSData  *data = [test dataUsingEncoding:NSUTF8StringEncoding];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonStr = [NSString stringWithFormat:@"%lu    %@",(unsigned long)jsonStr.length,jsonStr];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
    // 连接成功开启定时器
    if (!self.connectTimer) {
        [self addTimer];
    }
    [self.connectTimer setFireDate:[NSDate distantPast]];

    // 连接后,可读取服务器端的数据
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
    self.connected = YES;
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    data = [YSTCommonTools replaceNoUtf8:data];//去除非法数据
    NSString *text =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到消息:%@",text);
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
    if (text.length < 1) {
        return;
    }
    if (self.detegate && [self.detegate respondsToSelector:@selector(readDataWithMessage:)]) {
        [self.detegate readDataWithMessage:data];
    }
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"断开连接");
   //断开连接 更改连接状态
    [self.connectTimer setFireDate:[NSDate distantFuture]];
    self.connected = NO;
    //重新连接 知道连接成功
    [self startConnect];
}




@end
