//
//  GJBrowMaCell.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJBrowMaCell.h"

@interface GJBrowMaCell ()

@end

@implementation GJBrowMaCell

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

- (void)initializa
{
    CGFloat width = 20;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-width)/2, (self.height-width)/2, width, width)];
//    _imageView.image = _img;
    [self.contentView addSubview:_imageView];

}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
//        _imageView.backgroundColor = rColor(237, 237, 246);
        self.contentView.backgroundColor = rColor(237, 237, 246);
    }else{
//        _imageView.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    // Configure the view for the selected state
}

@end
