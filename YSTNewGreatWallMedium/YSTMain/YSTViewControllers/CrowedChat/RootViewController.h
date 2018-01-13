//
//  RootViewController.h
//  UUChatTableView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "UserModel.h"
enum {
    ChatWithChat = 1, //单聊
    ChatWitGroupChat = 2 , //群聊
};
typedef NSInteger ChatKind;
@interface RootViewController : UIViewController
@property (nonatomic, strong)GroupModel *model;
@property (nonatomic, assign) ChatKind ChatType;//聊天类型
@property (nonatomic, strong) UserModel *userModel;
@end
