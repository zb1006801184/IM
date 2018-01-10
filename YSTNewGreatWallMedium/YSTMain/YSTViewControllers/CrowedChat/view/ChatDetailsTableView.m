//
//  ChatDetailsTableView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "ChatDetailsTableView.h"
#import "CrowChatListTableViewCell.h"
#import "ZXChatMessageController.h"
#import "RootViewController.h"
#import "ChatDetailTopTableViewCell.h"
#import "ChatDetailCenterTableViewCell.h"
#import "ChatDetailsBottomTableViewCell.h"
#import "MembersViewController.h"

@interface ChatDetailsTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation ChatDetailsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.tableFooterView = [UIView new];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = YES;
    self.tableFooterView = [UIView new];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor colorWithHex:0xF5F5F5];

}

#pragma mark -UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_model.group == 1) {
        return 3;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"ChatDetailTopTableViewCell";
        ChatDetailTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ChatDetailTopTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.topClickButton addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.topicLabel.text = [NSString stringWithFormat:@"热聊标签: %@",_model.topic];
        ;
        cell.creatTimeLabel.text = [NSString stringWithFormat:@"创建时间: %@", [YSTCommonTools changeDate:[_model.createTime substringToIndex:10] :@"yyyy-MM-dd HH:mm:ss"]];
        cell.currueNumbelLabel.text = [NSString stringWithFormat:@"参与人数: %ld",_model.groupNumberByCurrent];
        cell.titleLabel.text = _model.groupName;
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:nil];
        [self topButtonStyleWith:cell.topClickButton];
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *cellID = @"ChatDetailCenterTableViewCell";
        ChatDetailCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ChatDetailCenterTableViewCell" owner:self options:nil]firstObject];
        }
        cell.descrbeLabel.text = _model.descrbe;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        static NSString *cellID = @"ChatDetailsBottomTableViewCell";
        ChatDetailsBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ChatDetailsBottomTableViewCell" owner:self options:nil]firstObject];
        }
        cell.curreNumbelLabel.text = [NSString stringWithFormat:@"%ld名成员",(long)_model.groupNumberByCurrent];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    view.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        MembersViewController *memberVC = [[MembersViewController alloc]init];
        memberVC.model = _model;
        [[YSTCommonTools getCurrentVC].navigationController pushViewController:memberVC animated:YES];
    }
}

#pragma mark - some click
- (void)topClick:(UIButton *)button {
    if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(topButtonClick:)]) {
        [self.chatDelegate topButtonClick:button];
    }
}


- (void)setModel:(GroupModel *)model {
    _model = model;
    [self reloadData];
}

- (void)topButtonStyleWith:(UIButton *)button {
    if (_model.group == 1) {
        [button setTitle:@"解散" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
        [button setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
    }else if (_model.group == 2) {
        button.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
        [button setTitle:@"退出" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
    }else if (_model.group == 3) {
        [button setTitle:@"加入" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithHex:0xF85959];
    }
}


@end
