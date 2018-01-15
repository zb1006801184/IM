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
    [self.tagView addTags:@[@"人工智能",@"互联网",@"金融",@"医疗",@"大农业",@"建筑",@"建筑",@"食品",
                        @"纺织",@"家具",@"文娱用品",@"材料",@"基础化工",@"造纸",@"电气",@"能源",@"车船航空",@"贸易",@"商务服务",@"消费服务",@"教育",@"传媒",@"综合"]];
    self.tagView.defaultConfig.tagSelectedTextColor = [UIColor whiteColor];
    self.tagView.defaultConfig.tagSelectedBackgroundColor = [UIColor colorWithHex:0xF44B50];
    self.tagView.defaultConfig.tagTextColor = [UIColor colorWithHex:666666];
    self.tagView.defaultConfig.tagBackgroundColor = [UIColor colorWithHex:0xF5F5F5];
    self.tagView.defaultConfig.tagShadowOpacity = 0;
    self.tagView.defaultConfig.tagTextFont = [UIFont systemFontOfSize:14];
    self.tagView.horizontalSpacing = 18;
    self.tagView.verticalSpacing = 10;
    self.tagView.scrollView.showsVerticalScrollIndicator = false;
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
