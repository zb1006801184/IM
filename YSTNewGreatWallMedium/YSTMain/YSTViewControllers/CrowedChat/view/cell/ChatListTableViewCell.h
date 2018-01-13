//
//  ChatListTableViewCell.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/20.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
