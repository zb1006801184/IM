//
//  CreatTextBaseTableViewCell.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatTextBaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeft;

@end
