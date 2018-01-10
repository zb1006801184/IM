//
//  CrowedChatListTableView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/11.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GroupModel;
@protocol groupChatDelegate <NSObject>
- (void)rightButtonClick:(GroupModel *)model :(NSInteger)section;
@end
@interface CrowedChatListTableView : UITableView
@property (nonatomic, weak) id <groupChatDelegate>chatDelegate;
@property (nonatomic, strong) NSMutableArray *dataList;
@end
