//
//  ChatListTableView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/20.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "ChatListTableView.h"
#import "InviteTableViewCell.h"
#import "ChatListTableViewCell.h"
#import "UserModel.h"
#import "RootViewController.h"
@interface ChatListTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ChatListTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.tableFooterView = [UIView new];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"ChatListTableViewCell";
    ChatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChatListTableViewCell" owner:self options:nil]firstObject];
    }
    UserModel *model = _dataList[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    cell.nickNameLabel.text = model.accepteId;
    cell.timeLabel.text = [YSTCommonTools changeDate:[model.occureTime substringToIndex:10] :@"MM-dd HH:mm:ss"];
    cell.contentLabel.text = model.content;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RootViewController *rootVC = [[RootViewController alloc]init];
    rootVC.ChatType = ChatWithChat;
    UserModel *model = _dataList[indexPath.row];
    rootVC.userModel = model;
    [[YSTCommonTools getCurrentVC].navigationController pushViewController:rootVC animated:YES];
}
- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    [self reloadData];
}

@end

