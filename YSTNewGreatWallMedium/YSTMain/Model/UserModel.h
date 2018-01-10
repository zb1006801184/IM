//
//  UserModel.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/1.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userIcon;
@property (nonatomic, strong) NSString *requestSourceSystem;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *accepteId;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *profession;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, assign) BOOL isSelect;//是否选中
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger isApply; //是成员还是申请 标识
@property (nonatomic, assign) BOOL isProhibit;//是否被禁言
/**
 用户基本信息存在本地

 @param model 需要存的数据对象
 */
+ (void)setModel:(UserModel *)model;

/**
 获取存在本地用户的基本信息

 @return 获取到用户的基本信息
 */
+ (UserModel *)getModel;
@end
