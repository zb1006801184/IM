//
//  GJView.h
//  MyDemo
//
//  Created by 郭杰 on 2017/11/29.
//  Copyright © 2017年 郭杰. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LeftButtonDelegate <NSObject>



@optional
// 左边按钮
-(void)leftButtonClick;

// 右边按钮
-(void)rightSettingButtonClick;



// 头像按钮
-(void)nameIconChangePicture;


-(void)qRCodeButton;



@end



@interface GJView : UIView

@property (nonatomic, assign) id<LeftButtonDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) UIImageView *imageView;


@property (nonatomic, strong) UIView *bottomView;

@end
