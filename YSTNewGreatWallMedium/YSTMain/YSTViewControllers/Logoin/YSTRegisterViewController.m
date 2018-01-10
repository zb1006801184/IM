//
//  YSTRegisterViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/1.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTRegisterViewController.h"

@interface YSTRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@end

@implementation YSTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)registerClick:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_userNameTextField.text.length < 1) {
        return;
    }
    if (_nickNameTextField.text.length < 1) {
        return;
    }
    [params setObject:_nickNameTextField.text forKey:@"nickName"];
    [params setObject:_userNameTextField.text forKey:@"user_id"];
    [params setObject:@"123456" forKey:@"userIcon"];
    [params setObject:@"iOS" forKey:@"requestSourceSystem"];
    
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_REGISTER option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


@end
