//
//  GJAddBrowCVCell.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJAddBrowCVCell.h"

@interface GJAddBrowCVCell ()



@end

@implementation GJAddBrowCVCell

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

- (void)layoutSubviews
{
    
}

- (void)setNameL:(UILabel *)nameL
{
    _nameL = nameL;
}


- (void)setImg:(UIImage *)img
{
    _img = img;
    self.imgView.image = _img;
}

- (void)initializa
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-(self.height-20-4))/2, 2, self.height-20-4, self.height-20-4)];
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-20, self.width, 20)];
    _nameL.textAlignment = NSTextAlignmentCenter;
    _nameL.font = [UIFont systemFontOfSize:13];
    _nameL.text = @"好的";
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_nameL];
}

@end
