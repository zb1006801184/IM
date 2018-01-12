//
//  GJMoreCell.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJMoreCell.h"

@implementation GJMoreCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializa];
    }
    
    return self;
}

- (void)initializa
{
    CGFloat itemW = (self.width-30);
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-itemW)/2, (self.width-itemW)/2, itemW, itemW)];
    [self.contentView addSubview:_imgView];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 12, self.width, 12)];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
}

@end
