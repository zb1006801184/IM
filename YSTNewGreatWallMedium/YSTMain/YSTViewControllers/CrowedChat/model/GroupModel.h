//
//  GroupModel.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property (nonatomic, assign)NSInteger id;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, assign)NSInteger groupNumberByMax;
@property (nonatomic, assign)NSInteger groupNumberByCurrent;
@property (nonatomic, assign)NSInteger groupType;
@property (nonatomic, copy)NSString *groupName;
@property (nonatomic, copy)NSString *descrbe;
@property (nonatomic, copy)NSString *topic;
@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, copy)NSString *groupUserType;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, copy)NSString *prohibitUserSpeak;
@property (nonatomic, assign)BOOL isProhibit;//是否被禁言
@property (nonatomic, assign) NSInteger group;//第几组（1我创建  2我的  3热门）

@end
