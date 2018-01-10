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
}

@end
