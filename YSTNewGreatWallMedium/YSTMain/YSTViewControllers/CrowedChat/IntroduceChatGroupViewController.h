//
//  IntroduceChatGroupViewController.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/18.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroduceChatGroupViewController : UIViewController
@property (nonatomic, copy) void (^getIntroduceDataBlock)(NSString *introduceStr);
@end
