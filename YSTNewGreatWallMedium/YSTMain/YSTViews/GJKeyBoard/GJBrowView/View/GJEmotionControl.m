//
//  GJEmotionControl.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJEmotionControl.h"

@implementation GJEmotionControl

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initializa];
    }
    
    return self;
}

- (void)initializa
{
    self.backgroundColor = rColor(237, 237, 246);
    self.currentPageIndicatorTintColor =[UIColor grayColor];
    self.pageIndicatorTintColor =[UIColor lightGrayColor];
    [self addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pageTurn:(UIPageControl*)sender
{
    
    self.index = [NSString stringWithFormat:@"%ld", self.currentPage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
