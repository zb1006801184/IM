//
//  CrowedChatViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/11.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "CrowedChatViewController.h"
#import "CrowedChatListTableView.h"
#import "CreateCrowedChatViewController.h"
#import "TitleView.h"
#import "IMNetModel.h"
#import "UserModel.h"
#import "GroupModel.h"
#import "ChatListTableView.h"
@interface CrowedChatViewController ()<titleViewDegetele,groupChatDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet CrowedChatListTableView *myTableView;
@property (nonatomic, strong)NSString *state;
@property (nonatomic, strong)GroupModel *model;
@property (nonatomic, strong) ChatListTableView *chatView;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation CrowedChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initTopView];
    [self getListData];
    self.myTableView.chatDelegate = self;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getListData];
    }];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self initChatList];
}
//私聊列表
- (void)initChatList {
     _chatView = [[ChatListTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_chatView];
    self.chatView.hidden = YES;
    [self getChatListNet];
}
- (void)initTopView {
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleView;
    titleView.degetele = self;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftButton setImage:[UIImage imageNamed:@"icon-return"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    
     _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [_rightButton setTitle:@"创建" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor colorWithHex:0xFB3C3C] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = right;
    [_rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)rightClick {
    CreateCrowedChatViewController *createVC = [[CreateCrowedChatViewController alloc]init];
    createVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:createVC animated:YES];
}

- (void)showMessageWithState:(NSString *)state groupName:(NSString *)groupName {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"确定%@ %@?",state,groupName] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
}

#pragma mark - Net
- (void)getListData {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel findAllGroupChatWith:userModel.userId success:^(id  _Nonnull responseObject) {
        NSArray *dataList = responseObject;
        self.myTableView.dataList = responseObject;
        [self.myTableView.mj_header endRefreshing ];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
//获取私聊列表
- (void)getChatListNet {
    [IMNetModel getRecentContactsWithsenderId:[UserModel getModel].userId success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] != 1) {
            //            [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)dissolveGroupChatNet {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel dissolveGroupChatWith:userModel.userId groupId:[NSString stringWithFormat:@"%ld",(long)_model.id] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            [self getListData];
        }
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)exitGroupChatNet {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel exitGroupChatWithUserId:userModel.userId groupId:[NSString stringWithFormat:@"%ld",_model.id] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            [self getListData];
        }
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)addGroupChatNet {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel addGroupChatWithUserId:userModel.userId groupId:[NSString stringWithFormat:@"%ld",_model.id] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            [self getListData];
        }
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - titleViewDegetele
- (void)chatRightClick:(UIButton *)button {
    self.myTableView.hidden = YES;
    self.chatView.hidden = NO;
    _rightButton.hidden = YES;
}
- (void)chatLeftClick:(UIButton *)button {
   
    self.myTableView.hidden = NO;
    self.chatView.hidden = YES;
    _rightButton.hidden = NO;
}
#pragma mark - groupChatDelegate
- (void)rightButtonClick:(GroupModel *)model :(NSInteger)section {
    if (section == 0) {
        _state = @"解散";
    }else if (section == 1) {
        _state = @"退出";
    }else if (section == 2) {
        _state = @"加入";
    }
    _model = model;
    [self showMessageWithState:_state groupName:model.groupName];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && [self.state isEqualToString:@"解散"]) {
        [self dissolveGroupChatNet];
    }else if (buttonIndex == 0 && [self.state isEqualToString:@"退出"]) {
        [self exitGroupChatNet];
    }else if (buttonIndex == 0 && [self.state isEqualToString:@"加入"]) {
        [self addGroupChatNet];
    }
}



@end
