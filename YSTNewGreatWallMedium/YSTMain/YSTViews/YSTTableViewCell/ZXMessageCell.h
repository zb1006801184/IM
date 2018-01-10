//
//  ZXMessageCell.h
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/23.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat.h"
@interface ZXMessageCell : UITableViewCell

@property(nonatomic,strong) NSMutableDictionary *modeldic;
@property (nonatomic, strong) Chat *model;
@property (nonatomic, strong) UIImageView *avatarImageView;                 // 头像
@property (nonatomic, strong) UIImageView *messageBackgroundImageView;      // 消息背景

@end
