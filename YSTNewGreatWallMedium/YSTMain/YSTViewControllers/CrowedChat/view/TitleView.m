//
//  TitleView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "TitleView.h"
@interface TitleView ()
@property (nonatomic, strong) UIImageView *lineLeft;
@property (nonatomic, strong) UIImageView *lineRight;
@property (nonatomic, strong) UIButton *groupChatButton;
@property (nonatomic, strong) UIButton *chatButton;

@end
@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.groupChatButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 13, 50, 18)];
    [self.groupChatButton setTitle:@"约聊" forState:UIControlStateNormal];
    
    [self.groupChatButton setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
    [self.groupChatButton setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateSelected];
    [self.groupChatButton addTarget:self action:@selector(groupChatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.groupChatButton];
     self.lineLeft = [[UIImageView alloc]initWithFrame:CGRectMake(19, self.groupChatButton.bottom+5, 12, 1.5)];
    self.lineLeft.backgroundColor = [UIColor colorWithHex:0xF44B50];
    [self addSubview:self.lineLeft];
    self.chatButton = [[UIButton alloc]initWithFrame:CGRectMake(100 - 50, 13, 50, 18)];
    [self.chatButton setTitle:@"私信" forState:UIControlStateNormal];
    [self.chatButton setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
    [self.chatButton setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateSelected];
    [self.chatButton addTarget:self action:@selector(chatButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.chatButton];
   self.lineRight = [[UIImageView alloc]initWithFrame:CGRectMake(19+50, self.chatButton.bottom+5, 12, 1.5)];
    self.lineRight.backgroundColor = [UIColor colorWithHex:0xF44B50];
    [self addSubview:self.lineRight];
    self.lineRight.hidden = YES;
    self.groupChatButton.selected = YES;
}

#pragma mark - titleViewDegetele

- (void)groupChatButtonClick:(UIButton *)button {
        self.lineLeft.hidden = NO;
        self.lineRight.hidden = YES;
        self.chatButton.selected = NO;
        self.groupChatButton.selected = YES;

    if (self.degetele && [self.degetele respondsToSelector:@selector(chatLeftClick:)]) {
        [self.degetele chatLeftClick:button];
    }
    
}
- (void)chatButton:(UIButton *)button {
        self.lineLeft.hidden = YES;
        self.lineRight.hidden = NO;
        self.groupChatButton.selected = NO;
        self.chatButton.selected = YES;

    if (self.degetele && [self.degetele respondsToSelector:@selector(chatRightClick:)]) {
        [self.degetele chatRightClick:button];
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self.groupChatButton setTitle:_titles[0] forState:UIControlStateNormal];
    [self.chatButton setTitle:_titles[1] forState:UIControlStateNormal];
}

@end
