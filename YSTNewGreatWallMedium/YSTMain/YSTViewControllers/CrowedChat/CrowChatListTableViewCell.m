//
//  CrowChatListTableViewCell.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/11.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "CrowChatListTableViewCell.h"
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>
@interface CrowChatListTableViewCell ()<TTGTextTagCollectionViewDelegate>
@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *tagView;

@end

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
//  self.pointImage.backgroundColor = [UIColor redColor];
    [self.tagView addTags:@[@"ITITITIT", @"服务行业", @"制造行业", @"电商"]];
    self.tagView.defaultConfig.tagSelectedTextColor = [UIColor whiteColor];
    self.tagView.defaultConfig.tagSelectedBackgroundColor = [UIColor colorWithHex:0xF44B50];
    self.tagView.defaultConfig.tagTextColor = [UIColor colorWithHex:666666];
    self.tagView.defaultConfig.tagBackgroundColor = [UIColor whiteColor];
    self.tagView.defaultConfig.tagShadowOpacity = 0;
    self.tagView.defaultConfig.tagTextFont = [UIFont systemFontOfSize:12];
    self.tagView.defaultConfig.tagCornerRadius = 6;
    self.tagView.defaultConfig.tagBorderWidth = 0.5;
    self.tagView.defaultConfig.tagBorderColor = [UIColor grayColor];
    self.tagView.horizontalSpacing = 18;
    self.tagView.verticalSpacing = 10;
    [self.tagView reload];
//  self.tagView.enableTagSelection = NO;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//所有uiview上的手势一直往下传(cell上的button自己响应)  直到cell可以响应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UIButton class]]) {
        return [super hitTest:point withEvent:event];
    }
    if ([view isKindOfClass:[UIView class]]) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

@end
