//
//  HomeSegmentView.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

/**
 *  左右切换的pageControl
 *
 *  效果为X易的效果
 */

#import <UIKit/UIKit.h>

typedef void(^XTSegmentControlBlock)(NSInteger index);

@class XTSegmentControl;

@protocol XTSegmentControlDelegate <NSObject>

- (void)segmentControl:(XTSegmentControl *)control selectedIndex:(NSInteger)index;

@end

@interface XTSegmentControl : UIView

@property (nonatomic, strong) UIColor * normalTextColor;

@property (nonatomic, strong) UIColor * higlightTextColor;

@property (nonatomic, strong) UIColor * lineBackground;

//回调的代理和block，2个用处一样爱用哪个用哪个
- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem delegate:(id <XTSegmentControlDelegate>)delegate;
- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle;

- (void)selectIndex:(NSInteger)index;

- (void)moveIndexWithProgress:(float)progress;

- (void)endMoveIndex:(NSInteger)index;

@end
