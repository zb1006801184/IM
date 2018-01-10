//
//  UserModel.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/1.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
MJLogAllIvars
MJCodingImplementation

+ (void)setModel:(UserModel *)model {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [defaults setObject:data forKey:userDefault_UserModel];
    [defaults synchronize];
}
+ (UserModel *)getModel {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:userDefault_UserModel];
    UserModel *model = nil;
    if (data) {
        model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return model;
}
@end
