//
//  MemberTableView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/18.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@protocol memberDegelete <NSObject>

/**
 左侧按钮点击

 @param model 对应的Model
 */
- (void)leftClick:(UserModel *)model;

/**
 右侧按钮的点击

 @param model 对应的Model
 */
- (void)rightClick:(UserModel *)model;
@end
@interface MemberTableView : UITableView
@property (nonatomic, weak)id <memberDegelete>memeberdegelete;
@property (nonatomic, strong) NSMutableArray *dataList;//数据源
@end
