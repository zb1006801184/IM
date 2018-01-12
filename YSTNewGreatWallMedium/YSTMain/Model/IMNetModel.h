//
//  IMNetModel.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//   IM部分网络请求

#import <Foundation/Foundation.h>

@interface IMNetModel : NSObject

/**
 获取群组列表
 
 @param userId 用户id
 @param success 成功回调
 @param failure 失败回调、、
 */
+ (void)findAllGroupChatWith:(nonnull NSString * )userId  success:(void (^_Nullable)( id  _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 解散群组
 
 @param userId 用户id（群主自己）
 @param groupId 群id
 @param success 成功
 @param failure 失败
 */
+ (void)dissolveGroupChatWith:(nonnull NSString *)userId  groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;


/**
 退出群组
 
 @param userId 用户id (群组自己)
 @param groupId 群组id
 @param success 成功
 @param failure 失败
 */
+ (void)exitGroupChatWithUserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 加入群组(需要申请)
 
 @param userId 用户id (群组自己)
 @param groupId 群组id
 @param success 成功
 @param failure 失败
 */
+ (void)addGroupChatWithUserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;



/**
 创建群组
 
 @param userId 群主id
 @param groupNumberByMax 最大人数
 @param groupType 群类型
 @param groupName 群名称
 @param descrbe 群描述 （简介）
 @param topic 群描述 （行业）
 @param imageUrl 群背景图
 @param groupUserType 当前用户在群中的角色
 */
+ (void)createGroupChatWithUserId:(nonnull NSString *)userId   groupNumberByMax:(nonnull NSString *)groupNumberByMax groupType:(nonnull NSString *)groupType groupName:(nonnull NSString *)groupName descrbe:(nonnull NSString *)descrbe  topic:(nonnull NSString *)topic  imageUrl:(nonnull NSString *)imageUrl  groupUserType:(nonnull NSString *)groupUserType success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 获取全部邀请人
 
 @param userId 用户id
 @param success 成功
 @param failure 失败
 */
+ (void)queryUserListWithUserId:(nonnull NSString *)userId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 群组信息
 
 @param userId 用户id
 @param groupId 群组id
 @param success 成功
 @param failure 失败
 */
+ (void)findGroupDetailWithUserId:(nonnull NSString *)userId  groupId:(nonnull NSString *)groupId  uccess:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;


/**
 查询待审批人员列表
 
 @param userId 用户id
 @param groupId 群组id
 @param success 成功
 @param failure 失败
 */
+ (void)queryApprovedListWithUserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId  uccess:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 踢出群聊
 
 @param groupId 群id
 @param userId 用户id
 @param manageId 管理员id
 @param success 成功
 @param failure 失败
 */
+ (void)kickOutGroupWithgroupId:(nonnull NSString *)groupId  userId:(nonnull NSString *)userId  manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;
/**
 拒绝加入群聊
 
 @param groupId 群id
 @param userId 用户id
 @param manageId 管理员id
 @param success 成功
 @param failure 失败
 */
+ (void)refuseUserJoinWithgroupId:(nonnull NSString *)groupId  userId:(nonnull NSString *)userId  manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 同意加入群聊
 
 @param groupId 群id
 @param userId 用户id
 @param manageId 管理员id
 @param success 成功
 @param failure 失败
 */
+ (void)aggreeTpJionWithgroupId:(nonnull NSString *)groupId  userId:(nonnull NSString *)userId  manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 上传图片
 
 @param data 数据
 @param success 成功
 @param failure 失败
 */
+ (void)filedUploadWithData:(nonnull NSData *)data type:(nonnull NSString *)type success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;
//YST_API_ADDGROUPCHAT

/**
 加入群聊（无需同意）
 
 @param userId 用户id
 @param groupId 群id
 @param success 成功
 @param failure 失败
 */
+ (void)addGroupChatWithuserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 禁言
 
 @param userId 用户id
 @param groupId 群组id
 @param manageId 管理员id
 @param success 成功
 @param failure 失败
 */
+ (void)prohibitUserSpeakWithuserIduserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;
/**
 解除禁言
 
 @param userId 用户id
 @param groupId 群组id
 @param manageId 管理员id
 @param success 成功
 @param failure 失败
 */
+ (void)removeProhibitUserSpeakWithuserIduserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;
/**
 私聊列表
 
 @param senderId 发送者id
 @param success 成功
 @param failure 失败
 */
+ (void)getRecentContactsWithsenderId:(nonnull NSString *)senderId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

@end

