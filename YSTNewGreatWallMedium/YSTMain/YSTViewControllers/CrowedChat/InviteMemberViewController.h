//
//  InviteMemberViewController.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteMemberViewController : UIViewController
@property (nonatomic, copy) void (^inviteSelectBlock)(NSString *select);
@end
