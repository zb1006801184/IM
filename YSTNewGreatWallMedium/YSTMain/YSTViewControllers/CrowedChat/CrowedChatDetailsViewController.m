//
//  CrowedChatDetailsViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "CrowedChatDetailsViewController.h"
#import "UIViewController+SetNav.h"
#import "ChatDetailsTableView.h"
#import "IMNetModel.h"
#import "UserModel.h"
#import "GroupModel.h"
#import "CrowedChatViewController.h"
@interface CrowedChatDetailsViewController ()<ChatDetailDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet ChatDetailsTableView *myTableView;

@property (nonatomic, strong)GroupModel *groupModel;
@end

@implementation CrowedChatDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _model.groupName;
    [self initLeftBack];
    _myTableView.chatDelegate = self;
    [self getChatNet];
}

- (void)topButtonClick:(UIButton *)button {
    [self initShowMessageView];
}

- (void)initShowMessageView {
    
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"你确定操作？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alerView show];
}
#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        switch (_model.group) {
            case 1:
                [self dissolveGroupChatNet];
                break;
            case 2:
                [self exitGroupChatNet];
                break;
            case 3:
                [self addGroupChatNet];
                break;
            default:
                break;
        }
    }
}
- (void)dissolveGroupChatNet {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel dissolveGroupChatWith:userModel.userId groupId:[NSString stringWithFormat:@"%ld",(long)_model.id] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            
        }
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        [self backGroup];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)exitGroupChatNet {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel exitGroupChatWithUserId:userModel.userId groupId:[NSString stringWithFormat:@"%ld",_model.id] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            
        }
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        [self backGroup];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)addGroupChatNet {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel addGroupChatWithUserId:userModel.userId groupId:[NSString stringWithFormat:@"%ld",_model.id] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
        }
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        [self backGroup];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - NET
- (void)getChatNet {
    [IMNetModel findGroupDetailWithUserId:[UserModel getModel].userId groupId:[NSString stringWithFormat:@"%ld",_model.id] uccess:^(id  _Nonnull responseObject) {
        if (_model.group == 1){
            NSArray *content = responseObject[@"content"];
            NSDictionary *dic = content[1];
            _groupModel = [GroupModel mj_objectWithKeyValues:dic];
            _groupModel.group = _model.group;
            _myTableView.model = _groupModel;
            return ;
        }
        _groupModel = [GroupModel mj_objectWithKeyValues:responseObject];
        _groupModel.group = _model.group;
        _myTableView.model = _groupModel;
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//返回群聊列表
- (void)backGroup {
    NSArray *VCArray = self.navigationController.viewControllers;
    for (UIViewController *vc in VCArray) {
        if ([vc isKindOfClass:[CrowedChatViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

@end
