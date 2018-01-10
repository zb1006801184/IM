//
//  CrowChatListTableViewCell.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/11.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "CrowChatListTableViewCell.h"

@implementation CrowChatListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightBtn.layer.cornerRadius = 3;
    self.tagLabel.layer.cornerRadius = 10;
    self.tagLabel.layer.borderWidth = 0.5;
    self.tagLabel.layer.borderColor = [UIColor colorWithHex:0xDDDDDD].CGColor;
    self.pointImage.layer.masksToBounds = YES;
    self.pointImage.layer.cornerRadius = 2.5;
//    self.pointImage.backgroundColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
