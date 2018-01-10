//
//  GJTVVoiceBtn.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJTVVoiceBtn.h"

@implementation GJTVVoiceBtn

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initializa];
    }
    
    return self;
}

- (void)initializa
{
    self.layer. masksToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 0.5f;
    
    self.hidden = YES;
    
    [self setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] forState:UIControlStateNormal];
    

    self.backgroundColor = rColor(241, 241, 248);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
