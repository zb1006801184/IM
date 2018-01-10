//
//  Chat.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/30.
//  Copyright © 2017年 zhubiao. All rights reserved.
//
#import "Chat.h"
#import "Chat+WCTTableCoding.h"
#import "DatabaseManager.h"
@implementation Chat

WCDB_IMPLEMENTATION(Chat)
WCDB_SYNTHESIZE(Chat, chatId)
WCDB_SYNTHESIZE(Chat, content)
WCDB_PRIMARY(Chat, chatId)

@end

@implementation Chat (WCDB)

+ (BOOL)createDatabaseWithTableName:(NSString *)tableName {
    return [[DatabaseManager shareInstance]createDatabaseWithTableName:tableName];
}

+ (BOOL)addObjectWithObject:(id)object tableName:(NSString *)tableName {
    WCTObject * Wobject = object;
    return [[DatabaseManager shareInstance]insertDatabaseWithObject:Wobject tableName:tableName];
}

+ (BOOL)deleteObjectWithChatId:(NSString *)chatId tableName:(NSString *)tableName {
    NSInteger chatID = [chatId integerValue];
    return [[DatabaseManager shareInstance]deleteDatabaseWhere:Chat.chatId == chatID tableName:tableName];
}

//+ (BOOL)updateDatabaseWithTableName:(NSString *)tableName onProperties:(id)onProperties withObject:(id)object withWhere:(id)where {
////    const WCTPropertyList  = onProperties;
//    return [[DatabaseManager shareInstance]updateDatabaseWithTableName:tableName onProperties:on withObject:object where:where];
//}
+ (NSArray *)selectObjectWithTableName:(NSString *)tableName withObjectClass:(id)object where:(NSString *)where {
    NSInteger chaId = [where integerValue];
    return [[DatabaseManager shareInstance]selectDatabaseWithTableName:tableName where:Chat.chatId == chaId object:object];
}
+ (NSArray *)selectObjectWithTableName:(NSString *)tableName {
    
    return [[DatabaseManager shareInstance]selectDatabaseWithTableName:tableName];
}
@end
