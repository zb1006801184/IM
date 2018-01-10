//
//  IntroduceView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/18.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol introduceDegelete <NSObject>

/**
 取消按钮的响应
 */
- (void)introduceViewCancle;

/**
 确定按钮的响应
 */
- (void)introduceViewSure;
@end
@interface IntroduceView : UIView
@property (nonatomic, weak)id <introduceDegelete>degelete;

/**
 获取全部选中的标签

 @return 获取到的
 */
- (NSArray<NSString *> *)getAllSelectStrings;
@end
