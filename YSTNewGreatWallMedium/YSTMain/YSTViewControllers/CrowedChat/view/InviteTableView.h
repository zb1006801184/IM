//
//  InviteTableView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@protocol invitedelegate <NSObject>

/**
 获取数据源 以便选数据

 @param dataList 数据源
 */
- (void)getDataList:(NSArray *)dataList;
@end
@interface InviteTableView : UITableView
@property (nonatomic, weak)id <invitedelegate>inviewDelegate;
@end
