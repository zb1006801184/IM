//
//  GJBrowShowV.h
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJEmotionControl;
//显示表情的view

@interface GJBrowShowV : UIView

- (id)initWithFrame:(CGRect)frame withEmoArray:(NSMutableArray *)emoArray;

@property (nonatomic, strong) UICollectionView *browShowCV;
@property (nonatomic, strong) GJEmotionControl *pageControll;

@property (nonatomic, copy) NSMutableArray *emoArray;

@property (nonatomic, copy) NSString *section;

//是否是来自ELBrowRaiseV的点击 YES是来自ELBrowRaiseV的点击
@property (nonatomic, assign) BOOL isSelected;

@end
