//
//  IssueMenueItem.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/28.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssueMenueItem : NSObject
/** 图片 */
@property (strong, nonatomic) UIImage *image;

/** 文字 */
@property (copy, nonatomic) NSString *title;


+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;

@end
