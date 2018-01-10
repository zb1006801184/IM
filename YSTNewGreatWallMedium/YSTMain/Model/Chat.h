//
//  Chat.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/30.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chat : NSObject

/**
 消息ID
 */
@property (nonatomic, assign) NSInteger chatId;

/**
 是否是发送者（类型）
 */
@property (nonatomic, assign) NSInteger type;

/**
 聊天的文字内容
 */
@property (nonatomic, strong) NSString *content;

/**
 接收者id
 */
@property (nonatomic, strong) NSString *accepteId;

/**
 事件
 */
@property (nonatomic, strong) NSString *event;

/**
 是否是群聊天
 */
@property (nonatomic, strong) NSString *groupChat;

/**
 发送者id
 */
@property (nonatomic, strong) NSString *senderId;


@end


@interface Chat (WCDB)

/**
 创建表

 @param tableName 表的名称
 @return 创建是否成功
 */
+ (BOOL)createDatabaseWithTableName:(NSString *)tableName;

/**
 存数据

 @param object 存入的数据模型
 @param tableName 表的名称
 @return 创建是否成功
 */
+ (BOOL)addObjectWithObject:(id)object  tableName:(NSString *)tableName;

/**
 删除

 @param chatId 需要删除的id
 @param tableName 表的名称
 @return 是否删除成功
 */
+ (BOOL)deleteObjectWithChatId:(NSString *)chatId tableName:(NSString *)tableName;


/**
 更改数据

 @param tableName 表的名字
 @param onProperties 属性
 @param object 对象
 @param where 位置
 @return 是否更新成功
 */
//+ (BOOL)updateDatabaseWithTableName:(NSString *)tableName onProperties:(id)onProperties  withObject:(id)object  withWhere:(id)where;


/**
 查询数据(根据chatId)

 @param tableName 表的名字
 @param object 对象类的名称
 @param where 查询的条件
 @return 查询的结果
 */
+ (NSArray *)selectObjectWithTableName:(NSString *)tableName  withObjectClass:(id)object where:(id)where;

/**
 查询数据（某个表下的所有数据）

 @param tableName 表的名称
 @return 查询到的所有数据
 */
+ (NSArray *)selectObjectWithTableName:(NSString *)tableName;

@end
