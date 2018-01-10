//
//  IntroduceView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/18.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "IntroduceView.h"
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>
@interface IntroduceView ()<TTGTextTagCollectionViewDelegate>
@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *tagView;
@end
@implementation IntroduceView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tagView addTags:@[@"IT", @"服务行业", @"制造行业", @"电商"]];
    self.tagView.defaultConfig.tagSelectedTextColor = [UIColor whiteColor];
    self.tagView.defaultConfig.tagSelectedBackgroundColor = [UIColor colorWithHex:0xF44B50];
    self.tagView.defaultConfig.tagTextColor = [UIColor colorWithHex:666666];
    self.tagView.defaultConfig.tagBackgroundColor = [UIColor colorWithHex:0xF5F5F5];
    self.tagView.defaultConfig.tagShadowOpacity = 0;
    self.tagView.defaultConfig.tagTextFont = [UIFont systemFontOfSize:14];
    self.tagView.horizontalSpacing = 18;
    self.tagView.verticalSpacing = 10;
    [self.tagView reload];
}
- (NSArray<NSString *> *)getAllSelectStrings {
    return self.tagView.allSelectedTags;
}
- (IBAction)cancelClick:(id)sender {
    if (self.degelete && [self.degelete respondsToSelector:@selector(introduceViewCancle)]) {
        [self.degelete introduceViewCancle];
    }
}

- (IBAction)sureClick:(id)sender {
    if (self.degelete && [self.degelete respondsToSelector:@selector(introduceViewSure)]) {
        [self.degelete introduceViewSure];
    }
}


@end
