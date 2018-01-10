//
//  IssueMenueButton.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/28.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "IssueMenueButton.h"

@implementation IssueMenueButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    
    CGFloat imageH = btnH * _heightRate / (1 + _heightRate) - self.imageTitleMargin;
    self.imageView.frame = CGRectMake(0, 0, btnW, imageH);
    
    self.titleLabel.frame = CGRectMake(0, imageH + self.imageTitleMargin, btnW, btnH - imageH - self.imageTitleMargin);
}


@end
