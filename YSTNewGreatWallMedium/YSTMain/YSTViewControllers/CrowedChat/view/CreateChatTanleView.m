//
//  CreateChatTanleView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "CreateChatTanleView.h"
#import "CreatTextBaseTableViewCell.h"
#import "CreatInputTableViewCell.h"
#import "UserModel.h"
@interface CreateChatTanleView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end
@implementation CreateChatTanleView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = YES;
    self.tableFooterView = [UIView new];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100;
//    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
}

#pragma mark -UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"简介",@"管理员",@"行业",@"被邀请者"];
    if (indexPath.row == 0) {
        static NSString *cellID = @"CreatInputTableViewCell";
        CreatInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CreatInputTableViewCell" owner:self options:nil]firstObject];
        }
        cell.inputTextField.text = _dataDic[@"zero"];
        return cell;
    }else {
        static NSString *cellID = @"CreatTextBaseTableViewCell";
        CreatTextBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CreatTextBaseTableViewCell" owner:self options:nil]firstObject];
        }
        cell.titleLabel.text = titles[indexPath.row - 1];
        if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.contentLabel.text = [UserModel getModel].nickName;
            cell.contentLabelLeft.constant = 15;
        }else if (indexPath.row == 1) {
            cell.contentLabel.text = _dataDic[@"one"];
        }else if (indexPath.row == 3) {
            cell.contentLabel.text = _dataDic[@"three"];

        }else if (indexPath.row == 4) {
            cell.contentLabel.text = _dataDic[@"four"];
        }
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.tableViewDegelete && [self.tableViewDegelete respondsToSelector:@selector(chatTableView:didSelectRowAtIndexPath:)]) {
        [self.tableViewDegelete chatTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 41;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.tableViewDegelete && [self.tableViewDegelete respondsToSelector:@selector(textfieldEnd:)]) {
        [self.tableViewDegelete textfieldEnd:textField];
    }
}
- (void)setDataDic:(NSMutableDictionary *)dataDic {
    _dataDic = dataDic;
    [self reloadData];
}

@end
