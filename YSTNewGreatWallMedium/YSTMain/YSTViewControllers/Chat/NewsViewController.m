//
//  NewsViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/22.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "NewsViewController.h"
#import "Constant.h"
#import "NewsCell.h"
#import "UserModel.h"
#import "Chat.h"
#import "ChatUserMessageViewController.h"
@interface NewsViewController ()
@property (nonatomic, strong) NSMutableArray <UserModel *>*dataList;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.newstableView];
    _dataList = [NSMutableArray array];
    if (self.type == 2) {
        [self getlistData];
    }else if (self.type == 1) {
//        [self getOfflineMessageNet];
    }
}

- (void)testDB {
    //创建表
    if ([Chat createDatabaseWithTableName:@"Chat"]) {
        NSLog(@"表创建成功");
    }
    //存数据
    Chat *model = [[Chat alloc]init];
    model.chatId = 1;
    model.content = @"内容";
    if ([Chat addObjectWithObject:model tableName:@"Chat"]) {
        NSLog(@"添加数据成功");
    }else {
        NSLog(@"添加数据失败");
    }
    //查数据(根据id)
    NSArray *models = [Chat selectObjectWithTableName:@"Chat" withObjectClass:Chat.class where:@"2"];
    //查某个表的全部数据
    NSArray *modelss = [Chat selectObjectWithTableName:@"Chat"];
    //删除数据
    if ([Chat deleteObjectWithChatId:[NSString stringWithFormat:@"%ld",(long)model.chatId]  tableName:@"Chat"]) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
}


- (void)getlistData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UserModel *model = [UserModel getModel];
//    if (model.userId.length < 1) {
//        return;
//    }
    [params setObject:@"zhubiao" forKey:@"user_id"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_USERCHATS option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *models = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([models.code  integerValue] == 0) {
            NSArray *list = responseObject[@"content"];
            for (NSDictionary *dic in list) {
                UserModel *model = [UserModel mj_objectWithKeyValues:dic];
                [_dataList addObject:model];
            }
            [_newstableView reloadData];
        }
        [self.view makeToast:models.msg duration:2 position:CSToastPositionCenter];


    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(UITableView *)newstableView {
    
    if (_newstableView == nil) {
        
        _newstableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStateHeight-kTabbarHeight) style:UITableViewStylePlain];
        _newstableView.delegate = self;
        _newstableView.dataSource = self;
        
        [self sethidden:self.newstableView];
    }
    return _newstableView;
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"newscell";
    NewsCell *cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] lastObject];
    }
    UserModel *model = _dataList [indexPath.row];
    cell.nameLable.text = model.userId;
    cell.contentLabel.text = model.content;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}


#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark  cell 点击界面之间的传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
//        ChatUserMessageViewController *chatUer = [[ChatUserMessageViewController alloc]init];
//        UserModel *model = _dataList[indexPath.row];
//        chatUer.userModel = model;
//        [self.navigationController pushViewController:chatUer animated:YES];
        return;
    }
    /**
     *   点击消息列表，这里进入一个聊天消息详情的界面。
     */
    UserModel *model = _dataList[indexPath.row];
    if (_chatVC == nil) {
    }
    _chatVC = [[ XYDJViewController  alloc] init];
    _chatVC.userModel = model;
    _chatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_chatVC animated:YES];

}
//左滑删除
//设置可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//滑动删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete ;
}

//修改左滑的按钮的字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) { //删除事件
        NSLog(@"删除");
        UserModel *model = _dataList[indexPath.row];
        [self deleteUserFriendWithModel:model];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
//隐藏多余线条
- (void)sethidden:(UITableView * )tableview
{
    UIView *view = [UIView new];
    view.backgroundColor=[UIColor clearColor];
    [self.newstableView setTableFooterView:view];
}

//删除好友
- (void)deleteUserFriendWithModel:(UserModel *)model {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UserModel *userModel = [UserModel getModel];
    [params setObject:userModel.userId forKey:@"user_id"];
    [params setObject:model.userId forKey:@"del_user_id"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_DELUSERCHATS option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0) {
            [self.dataList removeObject:model];
            [self.newstableView reloadData];
            [self.view makeToast:@"删除成功" duration:2 position:CSToastPositionCenter];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
//获取离线消息
- (void)getOfflineMessageNet {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UserModel *userModel = [UserModel getModel];
    if (userModel.userId.length < 1) {
        return;
    }
    [params setObject:userModel.userId forKey:@"senderId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_OFFLINEMESSAGE option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0) {
            NSArray *list = responseObject[@"content"];
            for (NSDictionary *dic in list) {
                UserModel *model = [UserModel mj_objectWithKeyValues:dic];
                [_dataList addObject:model];
            }
            [_newstableView reloadData];
        }
        [self.view makeToast:mainModel.msg duration:2 position:CSToastPositionCenter];

    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
