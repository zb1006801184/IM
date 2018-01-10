//
//  GJSysBrowCVCell.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJSysBrowCVCell.h"

@interface GJSysBrowCVCell ()


@end

@implementation GJSysBrowCVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializa];
    }
    
    return self;
}

- (void)setImg:(UIImage *)img
{
    _img = img;
    self.imgView.image = _img;
}


- (void)initializa
{
    CGFloat imgViewW = 30;

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width-imgViewW)/2, (self.width-imgViewW)/2, imgViewW, imgViewW)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:imgViewW-5];
    [self.contentView addSubview:_titleLabel];
    
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-imgViewW)/2, (self.width-imgViewW)/2, imgViewW, imgViewW)];
    _imgView.image = _img;
    [self.contentView addSubview:_imgView];
}

@end
