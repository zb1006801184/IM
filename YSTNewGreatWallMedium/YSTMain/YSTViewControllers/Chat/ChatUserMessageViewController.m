//
//  ChatUserMessageViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/5.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "ChatUserMessageViewController.h"

@interface ChatUserMessageViewController ()

@end

@implementation ChatUserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.userModel.userId;
}

- (IBAction)deleteHistoryClick:(id)sender {
    [self deleteMessageNet];
}


- (void)deleteMessageNet {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userModel.userId forKey:@"senderId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_DELETEMESSAGE option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0) {
            [self.view makeToast:mainModel.msg duration:2 position:CSToastPositionCenter];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
