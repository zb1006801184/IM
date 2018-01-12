//
//  CrowedChatListTableView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/11.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "CrowedChatListTableView.h"
#import "CrowChatListTableViewCell.h"
#import "ZXChatMessageController.h"
#import "RootViewController.h"
#import "CrowedChatDetailsViewController.h"
#import "GroupModel.h"
@interface CrowedChatListTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CrowedChatListTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.tableFooterView = [UIView new];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.tableFooterView = [UIView new];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //只有三个
    if (_dataList.count == 3) {
        NSArray *listData = _dataList[section];
        return listData.count;
    }
    if (_dataList.count == 2) {
        //只有俩个
        if (section == 0) {
            return 0;
        }
        NSArray *listData = _dataList[section - 1];
        return listData.count;
    }
    //只有一个
    if (_dataList.count == 1) {
        if (section == 0 || section == 1) {
            return 0;
        }
        NSArray *listData = _dataList[section - 2];
        return listData.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CrowChatListTableViewCell";
    GroupModel *model ;
    if (_dataList.count == 3) {
        NSArray *listData = _dataList[indexPath.section];
        model = listData[indexPath.row];
    }else if (_dataList.count == 2){
        //我创建的那组没有了。
        if (indexPath.section == 0) {
            return nil;
        }
        NSArray *listData = _dataList[indexPath.section - 1];
        model = listData[indexPath.row];
    }else if (_dataList.count == 1) {
        if (indexPath.section == 0 || indexPath.section == 1) {
            return nil;
        }
        NSArray *listData = _dataList[indexPath.section - 2];
        model = listData[indexPath.row];
        
    }
    CrowChatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CrowChatListTableViewCell" owner:self options:nil]firstObject];
    }
    if (indexPath.section == 1) {
        cell.rightBtn.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
        [cell.rightBtn setTitle:@"退出" forState:UIControlStateNormal];
        [cell.rightBtn setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];

    }
    else if (indexPath.section == 0){
        [cell.rightBtn setTitle:@"解散" forState:UIControlStateNormal];
        cell.rightBtn.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
        [cell.rightBtn setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];

    }
        else if (indexPath.section == 2) {
        [cell.rightBtn setTitle:@"加入" forState:UIControlStateNormal];
        [cell.rightBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        cell.rightBtn.backgroundColor = [UIColor colorWithHex:0xF85959];
    }
    [cell.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.titleLabel.text = model.groupName;
    cell.peopleLabel.text = [NSString stringWithFormat:@"参与人数:  %ld", (long)model.groupNumberByCurrent];
    cell.tagLabel.text = [NSString stringWithFormat:@"   %@   ",model.topic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15.5, 9, 50, 12)];
    NSArray *titleStr = @[@"我创建的",@"我的群聊",@"热门群聊"];
    title.textColor = [UIColor colorWithHex:0x999999];
    title.font = [UIFont systemFontOfSize:12];
    title.text= titleStr[section];
    [view addSubview:title];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_dataList.count == 2) {
        if (section == 0) {
            return 20;
        }
    }
    if (_dataList.count == 1) {
        if (section == 0 || section == 1) {
            return 20;
        }
    }
    if (_dataList.count == 3) {
        NSArray *listData  = _dataList[section];
        if (listData.count < 1) {
            return 20;
        }
        return CGFLOAT_MIN;
    }
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GroupModel *model ;
    if (_dataList.count == 3) {
        NSArray *listData = _dataList[indexPath.section];
        model = listData[indexPath.row];
    }else if (_dataList.count == 2){
        NSArray *listData = _dataList[indexPath.section - 1];
        model = listData[indexPath.row];
    }else if (_dataList.count == 1) {
        NSArray *listData = _dataList[indexPath.section - 2];
        model = listData[indexPath.row];
    }

    if (indexPath.section == 2) {
        CrowedChatDetailsViewController *detailVC = [[CrowedChatDetailsViewController alloc]init];
        detailVC.hidesBottomBarWhenPushed = YES;
        model.group = 3;
        detailVC.model = model;
        [[YSTCommonTools getCurrentVC].navigationController pushViewController:detailVC animated:YES];
        return;
    }
    if (indexPath.section == 0) {
        model.group = 1;
    }else if (indexPath.section == 1) {
        model.group = 2;
    }
    RootViewController *chatVC = [[RootViewController alloc]init];
    chatVC.hidesBottomBarWhenPushed = YES;
    chatVC.model = model;
    [[YSTCommonTools getCurrentVC].navigationController pushViewController:chatVC animated:YES];
}

- (void)rightBtnClick:(UIButton *)button {
    CrowChatListTableViewCell *cell = (CrowChatListTableViewCell *)[[button superview] superview];
    NSIndexPath *index = [self indexPathForCell:cell];
    GroupModel *model;
    if (_dataList.count == 3) {
        NSArray *listData = _dataList[index.section];
        model = listData[index.row];
    }else if (_dataList.count == 2){
        NSArray *listData = _dataList[index.section - 1];
        model = listData[index.row];
    }else if (_dataList.count == 1) {
        NSArray *listData = _dataList[index.section - 1];
        model = listData[index.row];
    }
    
    if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(rightButtonClick::)]) {
        [self.chatDelegate rightButtonClick:model :index.section];
    }
}

- (void)setDataList:(NSMutableArray *)dataList {
    _dataList = dataList;
    [self reloadData];
}


@end
