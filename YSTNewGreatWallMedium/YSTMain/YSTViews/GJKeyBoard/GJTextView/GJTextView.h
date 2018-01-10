//
//  GJTextView.h
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BEditingBlock)();

@protocol GJTextViewDelegate <NSObject>

- (void)sendMessageText:(NSString *)message;

@end

//输入框
@interface GJTextView : UITextView

@property (nonatomic, copy) BEditingBlock bEditingBlock;

@property (nonatomic, weak) id<GJTextViewDelegate>textDelegate;

/**
 *  GJTextView所占高度
 */
@property (nonatomic, copy)void(^changeHeightBlock)(CGFloat height);

@end
