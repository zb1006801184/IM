//
//  MembersViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/18.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "MembersViewController.h"
#import "UIViewController+SetNav.h"
#import "MemberTableView.h"
#import "TitleView.h"
#import "IMNetModel.h"
#import "UserModel.h"
@interface MembersViewController ()<titleViewDegetele,memberDegelete>
@property (weak, nonatomic) IBOutlet UITextField *searchInputTextField;
@property (weak, nonatomic) IBOutlet MemberTableView *myTableView;
//@property (nonatomic, strong) MemberTableView *rightTableView;
@property (weak, nonatomic) IBOutlet MemberTableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *leftDataList;
@property (nonatomic, strong) NSMutableArray *rightDataList;
@end

@implementation MembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _myTableView.memeberdegelete = self;
    _rightTableView.memeberdegelete = self;
    self.title = @"群成员";
    [self initLeftBack];
    [self initTitleViews];
    [self getMemberListNet];
    [self getApplyNet];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    _rightTableView = [[MemberTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, self.view.size.height)];
//    [self.view addSubview:_rightTableView];
//    _rightTableView.tableFooterView = [[UIView alloc]init];
//    _rightTableView.memeberdegelete = self;
//    _rightTableView.hidden = YES;
}
- (void)initTitleViews {
    TitleView *view = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    view.titles = @[@"成员",@"申请"];
    view.degetele  = self;
    self.navigationItem.titleView = view;
}
#pragma mark - titleViewDegetele
- (void)chatLeftClick:(UIButton *)button {
    _rightTableView.hidden = YES;
}
- (void)chatRightClick:(UIButton *)button {
    _rightTableView.hidden = NO;
}
#pragma mark - Net
- (void)getMemberListNet {
    _leftDataList = [NSMutableArray array];
    [IMNetModel findGroupDetailWithUserId:[UserModel getModel].userId groupId:[NSString stringWithFormat:@"%ld",_model.id] uccess:^(id  _Nonnull responseObject) {
        NSMutableArray *first =[NSMutableArray array];
        NSDictionary *firstDic = responseObject[@"content"][0];
        UserModel *fiestModel = [UserModel mj_objectWithKeyValues:firstDic];
        [first addObject:fiestModel];
        NSMutableArray *two = [NSMutableArray array];
        NSArray *list = responseObject[@"content"][1][@"groups"];
        //被禁言id
        NSArray *userIds = [responseObject[@"content"][1][@"prohibitUserSpeak"] componentsSeparatedByString:@","];
        //遍历解析数据
        for (NSDictionary *dic in list) {
            UserModel *model = [UserModel mj_objectWithKeyValues:dic];
            model.isApply = 1;
            
            //筛选除被禁言的人
            for (NSString *userid in userIds) {
                if ([userid isEqualToString:model.userId]) {
                    model.isProhibit = YES;
                }
            }
            
            [two addObject:model];
        }
        [_leftDataList addObject:first];
        [_leftDataList addObject:two];
        _myTableView.dataList = _leftDataList;
        [_myTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)getApplyNet {
    _rightDataList = [NSMutableArray array];
    [IMNetModel queryApprovedListWithUserId:[UserModel getModel].userId groupId:[NSString stringWithFormat:@"%ld",_model.id] uccess:^(id  _Nonnull responseObject) {
        NSArray *list = responseObject[@"content"][0][@"applyUser"];
        NSMutableArray *data = [NSMutableArray array];
        for (NSDictionary *dic in list) {
            UserModel *model = [UserModel mj_objectWithKeyValues:dic];
            model.isApply = 2;
            [data addObject:model];
        }
        [_rightDataList addObject:data];
        _rightTableView.dataList = _rightDataList;
        [_rightTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)kickOutGroupNetWith:(UserModel *)model {
    [IMNetModel kickOutGroupWithgroupId:[NSString stringWithFormat:@"%ld",_model.id] userId:model.userId manageId:[UserModel getModel].userId success:^(id  _Nonnull responseObject) {
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        if ([responseObject[@"code"] integerValue] == 0) {
            [self getMemberListNet];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)refuseUserJoinNet:(UserModel *)model {
    [IMNetModel refuseUserJoinWithgroupId:[NSString stringWithFormat:@"%ld",_model.id] userId:model.userId manageId:[UserModel getModel].userId success:^(id  _Nonnull responseObject) {
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        if ([responseObject[@"code"] integerValue] == 0) {
            [self getApplyNet];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)agreeToJoinNet:(UserModel *)model {
    [IMNetModel aggreeTpJionWithgroupId:[NSString stringWithFormat:@"%ld",_model.id] userId:model.userId manageId:[UserModel getModel].userId success:^(id  _Nonnull responseObject) {
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        if ([responseObject[@"code"] integerValue] == 0) {
            [self getApplyNet];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)prohibitUserSpeakNet:(UserModel *)model {
    [IMNetModel prohibitUserSpeakWithuserIduserId:model.userId groupId:[NSString stringWithFormat:@"%ld",_model.id] manageId:[UserModel getModel].userId success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
            [self getMemberListNet];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)removeProhibitUserSpeakNet:(UserModel *)model {
    [IMNetModel removeProhibitUserSpeakWithuserIduserId:model.userId groupId:[NSString stringWithFormat:@"%ld",_model.id] manageId:[UserModel getModel].userId success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
            [self getMemberListNet];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma  mark - memberDegelete
- (void)leftClick:(UserModel *)model {
    if (model.isApply == 2) {
        //拒绝
        [self refuseUserJoinNet:model];
        
    }else {
        
        if (!model.isProhibit) {
            //禁言
            [self prohibitUserSpeakNet:model];
        }else {
            //解除禁言
            [self refuseUserJoinNet:model];
        }
        
    }
}
- (void)rightClick:(UserModel *)model {
    if (model.isApply == 1) {
        //踢出群聊
        [self kickOutGroupNetWith:model];
    }else if (model.isApply == 2) {
        //同意
        [self agreeToJoinNet:model];
    }
}
@end
