//
//  Chat+WCTTableCoding.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/30.
//Copyright © 2017年 zhubiao. All rights reserved.
//

#import "Chat+WCTTableCoding.h"
#import <WCDB/WCDB.h>
#import "Chat.h"
//@interface Chat_WCTTableCoding (WCTTableCoding) <WCTTableCoding>
//
//
//
//@end
@interface Chat (WCTTableCoding) <WCTTableCoding>
WCDB_PROPERTY(chatId)
WCDB_PROPERTY(content)
WCDB_PROPERTY(type)
WCDB_PROPERTY(accepteId)
WCDB_PROPERTY(event)
WCDB_PROPERTY(senderId)
WCDB_PROPERTY(groupChat)

@end
