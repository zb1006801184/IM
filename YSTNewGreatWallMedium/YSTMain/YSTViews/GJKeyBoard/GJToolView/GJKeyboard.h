//
//  GJKeyboard.h
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GJKeyboardDelegate <NSObject>

- (void)sendMessageText:(NSString *)message;
- (void)sendMessageTextheight:(CGFloat )messageheight;


@end

@class GJTextView, GJVoiceView, GJBrowView, GJMoreView, GJTVVoiceBtn;
//带有语音、表情、更多按钮 并带有输入框的view
@interface GJKeyboard : UIView

@property (nonatomic, strong) UIButton *voiceBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *browBtn;
@property (nonatomic, strong) GJTVVoiceBtn *tvVoiceBtn;
@property (nonatomic, strong) GJTextView *textView;

@property (nonatomic, strong) GJBrowView *browView;
@property (nonatomic, strong) GJMoreView *moreView;

@property (nonatomic, weak) id<GJKeyboardDelegate>delegate;

@property (nonatomic, copy) void(^changeHeightBlock)(CGFloat height);

@property (nonatomic, strong)NSTimer *timer;

@end
