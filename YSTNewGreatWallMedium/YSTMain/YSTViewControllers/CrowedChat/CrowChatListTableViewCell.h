//
//  CrowChatListTableViewCell.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/11.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CrowChatDegelete <NSObject>

@end

@interface CrowChatListTableViewCell : UITableViewCell

@property (nonatomic, weak) id <CrowChatDegelete>degelete;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pointImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//标签数据源
@property (nonatomic, strong) NSArray *dataList;

@end
