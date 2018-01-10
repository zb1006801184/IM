//
//  YSTLoginViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTLoginViewController.h"
#import "YSTTabBarViewController.h"
#import "AppDelegate.h"
#import "YSTRegisterViewController.h"
#import "UserModel.h"

@interface YSTLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;


@end

@implementation YSTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginClick:(id)sender {
    [self getUserInfo];
}
- (IBAction)registerClick:(id)sender {
    YSTRegisterViewController *registerVC = [[YSTRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)getUserInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_passWordTextField.text.length < 1) {
        return;
    }
    [params setObject:_passWordTextField.text forKey:@"user_id"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_USERCHAT option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        UserModel *model = [UserModel mj_objectWithKeyValues:responseObject];
        if ([model.code integerValue] == 0) {
            [UserModel setModel:model];
            [self.view makeToast:@"登录成功" duration:2 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });

        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)login {
    YSTTabBarViewController *tabbarvc = [[YSTTabBarViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow setRootViewController:tabbarvc];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

@end
