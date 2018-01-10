//
//  GJView.m
//  MyDemo
//
//  Created by 郭杰 on 2017/11/29.
//  Copyright © 2017年 郭杰. All rights reserved.
//

#import "GJView.h"


@interface GJView ()









@end


@implementation GJView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        _scrollView = [self setScrollViewUI];
        
        
        
        [self addContentInScrollViewWithImage:@"timg.jpg" ImageHeight:120 UserInfoViewHeight:180 andUserInfoViewX:20 andUserInfoViewFrameY:20 andBottomViewFrame:40];
        
        
        [self addSubview:_scrollView];
        
        CGFloat rightWidth = 50;
        [self addButtonOnNavigationBarWithLeftFrame:CGRectMake(5, 25, 50, 30) andRightFrame:CGRectMake(self.bounds.size.width - rightWidth, 25, rightWidth, 30) andViewTitle:@"我的"];
        
    }
    return self;
}

-(void)addButtonOnNavigationBarWithLeftFrame:(CGRect)leftFrame andRightFrame:(CGRect)rightFrame andViewTitle:(NSString *)viewTitle{
    
    
    
    
    UIButton *addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addFriendBtn.frame = leftFrame;
    
    [addFriendBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    
    addFriendBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    
    [addFriendBtn addTarget:self action:@selector(addFriendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self insertSubview:addFriendBtn aboveSubview:_imageView];
    
    
    
    
    
    CGFloat labelWidth = 50;
    CGFloat labelHeight = 30;
    CGFloat labelX = self.bounds.size.width / 2 - labelWidth / 2;
    CGFloat labelY = 25;
    
    
    UILabel *viewTitleLabel = [[UILabel alloc] init];
    
    
    viewTitleLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
//    viewTitleLabel.center = CGPointMake(self.bounds.size.width / 2, addFriendBtn.center.y);
    
    
    viewTitleLabel.text = viewTitle;
    
    
    [self insertSubview:viewTitleLabel aboveSubview:_imageView];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = rightFrame;
    
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self insertSubview:rightBtn aboveSubview:_imageView];
    
    
    
    
}


-(void)rightBtnClick {
    
    if ([self.delegate respondsToSelector:@selector(rightSettingButtonClick)]) {
        [self.delegate rightSettingButtonClick];
    }
    
    
    
}

-(void)addFriendBtnClick {
    
    
    if ([self.delegate respondsToSelector:@selector(leftButtonClick)]) {
        
        
        [self.delegate leftButtonClick];
        
        
    }
    
//    NSLog(@"添加好友");
    
    
}




#pragma mark - 二维码
-(void)twoCodeBtnClick {
   
    
    if ([self.delegate respondsToSelector:@selector(qRCodeButton)]) {
        
        
        [self.delegate qRCodeButton];
        
        
    }
    
}






-(void)addContentInScrollViewWithImage:(NSString *)imageString ImageHeight:(CGFloat)imageHeight UserInfoViewHeight:(CGFloat)userInfoViewHeight andUserInfoViewX:(CGFloat)userInfoViewX andUserInfoViewFrameY:(CGFloat)userInfoY andBottomViewFrame:(CGFloat)bottomY {
    
    
    
    
//    顶部图片
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageHeight)];
//

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageHeight)];
    
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageHeight)];
    
    
    imageView.image = [UIImage imageNamed:imageString];
//    _imageView.image = [UIImage imageNamed:imageString];
    
    
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.layer.masksToBounds = YES;
    [self.scrollView addSubview:imageView];
    
    self.imageView = imageView;
    
    
  
    
    
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(userInfoViewX, CGRectGetMaxY(self.imageView.frame) - 20 - userInfoY , self.bounds.size.width - 2 * userInfoViewX, userInfoViewHeight)];
    
    CGFloat centerX = userInfoView.frame.size.width / 2;
//    设置用户信息
    
    
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    userIcon.center = CGPointMake(centerX , 50);
    
    userIcon.image = [UIImage imageNamed:@"timg.jpg"];
    
    userIcon.layer.cornerRadius = 40;
    userIcon.layer.masksToBounds = YES;
    
    [userInfoView addSubview:userIcon];
    
    
    
    
    UIButton *TwoCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    TwoCodeBtn.frame = CGRectMake(0, 0, 35, 35);
    TwoCodeBtn.center = CGPointMake(CGRectGetMaxX(userInfoView.frame) - 70, userIcon.center.y);
    
    
    [TwoCodeBtn setBackgroundImage:[UIImage imageNamed:@"timg.jpg"] forState:UIControlStateNormal];
    
    [TwoCodeBtn addTarget:self action:@selector(twoCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:TwoCodeBtn];
    
    
    
    
    
    
//    名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerX - 30, CGRectGetMaxY(userIcon.frame), 50, 20)];
    
//    nameLabel.center = CGPointMake(centerX - 10, CGRectGetMaxY(userIcon.frame) + 15);
    
    nameLabel.text = @"昵称：";
    nameLabel.font = [UIFont systemFontOfSize:12.0];
    [userInfoView addSubview:nameLabel];
    
    
    //    TODO: 个人信息 背景颜色
    userInfoView.backgroundColor = [UIColor whiteColor];
    
    userInfoView.layer.borderColor = [UIColor grayColor].CGColor;
    
    userInfoView.layer.borderWidth = 2.0;
    
    
    [self.scrollView addSubview:userInfoView];
    
    
    
    
    
    
    
    
    
    
//     用户名
    
    UILabel *nameUserLab = [[UILabel alloc] initWithFrame:CGRectMake(centerX + 5, CGRectGetMaxY(userIcon.frame), 50, 20)];
    
//    nameUserLab.center = CGPointMake(centerX + 10, CGRectGetMaxY(userIcon.frame) + 15);
    
    nameUserLab.text = @"6666";
    nameUserLab.font = [UIFont systemFontOfSize:12.0];
    [userInfoView addSubview:nameUserLab];
    
    
//    userInfoView.backgroundColor = [UIColor redColor];
    
    
    [self.scrollView addSubview:userInfoView];
    
    
    
    
    
//    简介
    UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(userIcon.frame), CGRectGetMaxY(nameUserLab.frame), userInfoView.frame.size.width, 20)];
    
    summaryLabel.center = CGPointMake(CGRectGetMidX(userIcon.frame), CGRectGetMaxY(nameUserLab.frame) + 10);
    
    summaryLabel.textAlignment = NSTextAlignmentCenter;
    summaryLabel.text = @"简介:世界那么大，我想出去走走！";
    
    summaryLabel.font = [UIFont systemFontOfSize:12.0];
    [userInfoView addSubview:summaryLabel];
    
//    简介 内容
//    UILabel *summaryTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(summaryLabel.frame), CGRectGetMaxY(nameUserLab.frame), 150, 20)];
//
//    summaryTextLabel.text = @"世界那么大，我想出去走走！";
//
//    summaryTextLabel.font = [UIFont systemFontOfSize:12.0];
//    [userInfoView addSubview:summaryTextLabel];
//
    
    
    
    NSArray *arryList = @[@"直播",@"问答",@"咨询",@"视频",@"关注",@"粉丝"];
    
    NSArray *arrayContent = @[@"9",@"15",@"14",@"43",@"9",@"89"];
//    int col = 6;
    
    CGFloat btnWidth = (userInfoView.frame.size.width - 30) / 6 ;
    

    
//    底部状态栏
    for (int i = 0; i < arryList.count; i++) {
        
        
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:arryList[i] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(btnWidth * i + 15, userInfoView.frame.size.height - 30, 50, 20);
        
        
        [userInfoView addSubview:btn];
        
        
        
        
        UILabel *lab = [[UILabel alloc] init];
        
        lab.text = arrayContent[i];
        
        lab.frame = CGRectMake(0, 0, 50, 20);
        lab.font = [UIFont systemFontOfSize:11.0];
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.center = CGPointMake(btn.center.x, CGRectGetMinY(btn.frame) - 5);
        
        [userInfoView addSubview:lab];
        
        
        
    }
    
    
    
    
    
//     底部视图
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userInfoView.frame), self.bounds.size.width - 40, self.bounds.size.height - CGRectGetMaxY(userInfoView.frame))];
    
//    _bottomView.backgroundColor = [UIColor blueColor];
    
    
    [self.scrollView addSubview:_bottomView];
    
    
    
    
}


-(UIScrollView *)setScrollViewUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
//    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height + 0.00001);
    scrollView.bounces = YES;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    
    
    
    return scrollView;
}





@end
