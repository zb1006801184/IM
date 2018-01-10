//
//  IssueMenueItem.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/28.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "IssueMenueItem.h"

@implementation IssueMenueItem
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title
{
    IssueMenueItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    
    return item;
}
@end
