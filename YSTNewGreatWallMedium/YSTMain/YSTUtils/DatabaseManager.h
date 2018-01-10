//
//  DatabaseManager.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/30.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<WCDB/WCDB.h> 
@interface DatabaseManager : NSObject
+ (instancetype)shareInstance;

/**
 创建数据库
 
 @param tableName 表名称
 @return 是否创建成功
 */
- (BOOL)createDatabaseWithTableName:(NSString *)tableName;

/**
 存数据

 @param object 数据模型对象
 @param tableName 表名称
 @return 是否成功
 */
- (BOOL)insertDatabaseWithObject:(WCTObject *)object tableName:(NSString *)tableName;

/**
 删除表中数据

 @param condition 位置
 @param tableName 表名称
 @return 是否成功
 */
- (BOOL)deleteDatabaseWhere:(const WCTCondition &)condition tableName:(NSString *)tableName;

/**
 更新表中的数据

 @param tableName 表名称
 @param properties 属性
 @param object 对象
 @param condition 位置
 @return 是否成功
 */
//- (BOOL)updateDatabaseWithTableName:(NSString *)tableName onProperties:(const WCTPropertyList &)properties withObject:(WCTObject *)object where:(const WCTCondition &)condition;

- (NSArray *)selectDatabaseWithTableName:(NSString *)tableName;

/**
 存入数据
 
 @param array 对象模型
 @param tableName 表的名称
 @return 是否成功
 */
- (BOOL)insertDatabaseWithArray:(NSArray *)array tableName:(NSString *)tableName;


/**
 查数据

 @param tableName 表名称
 @param condition 查询条件
 @param object 模型对象
 @return 查询到的结果
 */
- (NSArray *)selectDatabaseWithTableName:(NSString *)tableName where:(const WCTCondition &)condition  object:(id)object;
@end
