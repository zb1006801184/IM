//
//  ChatDetailsTableView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
@protocol ChatDetailDelegate <NSObject>
//解散 退出 按钮的响应
- (void)topButtonClick:(UIButton *)button;
@end
@interface ChatDetailsTableView : UITableView
@property (nonatomic,weak)id <ChatDetailDelegate>chatDelegate;
@property (nonatomic, strong) GroupModel *model;//群信息
@end
