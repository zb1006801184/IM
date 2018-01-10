//
//  ChatDetailTopTableViewCell.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatDetailTopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *topClickButton;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currueNumbelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@end
