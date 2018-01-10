//
//  ZXChatMessageController.h
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/23.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat.h"
@class ZXChatMessageController;
@protocol ZXChatMessageControllerDelegate <NSObject>
- (void) didTapChatMessageView:(ZXChatMessageController *)chatMessageViewController;

@end
@interface ZXChatMessageController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) id <ZXChatMessageControllerDelegate> delegate;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;


/**
 *  改变数据源方法，添加一条消息，刷新数据
 *
 *  @param message 添加的消息
 */
- (void) addNewMessage:(NSMutableDictionary *)message;

/**
 刷新数据

 @param model 数据对象
 */
- (void)addMessageModel:(Chat *)model;
/**
 *   添加一条消息就让tableView滑动
 */
- (void) scrollToBottom;
@end
