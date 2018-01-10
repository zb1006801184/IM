//
//  MemberTableView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/18.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "MemberTableView.h"
#import "MemberTableViewCell.h"
#import "UserModel.h"
@interface MemberTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation MemberTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.tableFooterView = [UIView new];
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
    self.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
}

#pragma  mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        NSMutableArray *data = _dataList[section];
        return data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"MemberTableViewCell";
    MemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSArray *data = _dataList[indexPath.section];
    UserModel *model = data[indexPath.row];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MemberTableViewCell" owner:self options:nil]firstObject];
    }
    cell.rightButton.hidden = NO;
    cell.leftButton.hidden = NO;
    //第一组管理员
    if (_dataList.count == 2 && indexPath.section == 0) {
        cell.rightButton.hidden = YES;
        cell.leftButton.hidden = YES;
    }
    if (_dataList.count == 2 && indexPath.section == 1) {
        cell.leftButton.layer.borderWidth = 0.5;
        cell.leftButton.layer.borderColor = [UIColor colorWithHex:0x999999].CGColor;
        cell.leftButton.layer.cornerRadius = 3;
        cell.rightButton.layer.borderWidth = 0.5;
        cell.rightButton.layer.borderColor = [UIColor colorWithHex:0x999999].CGColor;
        cell.rightButton.layer.cornerRadius = 3;
        [cell.leftButton setTitle:@"禁言" forState:UIControlStateNormal];
        if (model.isProhibit) {
            //显示禁言
            [cell.leftButton setTitle:@"已禁言" forState:UIControlStateNormal];
        }
    }
    if (_dataList.count == 1 ) {

        cell.leftButton.layer.borderWidth = 0.5;
        cell.leftButton.layer.borderColor = [UIColor colorWithHex:0x999999].CGColor;
        cell.leftButton.layer.cornerRadius = 3;
        [cell.leftButton setTitle:@"拒绝" forState:UIControlStateNormal];
        cell.rightButton.layer.borderWidth = 0.5;
        cell.rightButton.layer.borderColor = [UIColor colorWithHex:0x999999].CGColor;
        [cell.rightButton setTitle:@"同意" forState:UIControlStateNormal];
        cell.rightButton.backgroundColor = [UIColor colorWithHex:0xF85959];
        cell.rightButton.layer.cornerRadius = 3;

    }
    
    cell.nameLabel.text = model.nickName;
    cell.companyLabel.text = [NSString stringWithFormat:@"%@ %@",model.companyName,model.job];
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:nil];
    [cell.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headView.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 9, 80, 12)];
    title.font = [UIFont systemFontOfSize:12];
    title.textColor = [UIColor colorWithHex:0x999999];
    [headView addSubview:title];
    NSArray *data = _dataList[section];
    if (_dataList.count == 1) {
        title.text = [NSString stringWithFormat:@"新申请 %ld人",data.count];
        return headView;
    }
    if (section == 0) {
        title.text = [NSString stringWithFormat:@"管理员 %ld人",data.count];
    }
    if (section == 1) {
        title.text = [NSString stringWithFormat:@"成员 %ld人",data.count];
    }
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)setDataList:(NSMutableArray *)dataList {
    _dataList = dataList;
    [self reloadData];
}

- (void)leftButtonClick:(UIButton *)button{
    MemberTableViewCell *cell = (MemberTableViewCell *)[[button superview]superview];
    NSIndexPath *index = [self indexPathForCell:cell];
    UserModel *model = _dataList[index.section][index.row];
    if (self.memeberdegelete && [self.memeberdegelete respondsToSelector:@selector(leftClick:)]) {
        model.section = 2;
        [self.memeberdegelete leftClick:model];
    }
}

- (void)rightButtonClick:(UIButton *)button{
    MemberTableViewCell *cell = (MemberTableViewCell *)[[button superview]superview];
    NSIndexPath *index = [self indexPathForCell:cell];
    UserModel *model = _dataList[index.section][index.row];
    if (self.memeberdegelete && [self.memeberdegelete respondsToSelector:@selector(rightClick:)]) {
        model.section = 1;
        [self.memeberdegelete rightClick:model];
    }

}
@end
