//
//  InviteTableView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "InviteTableView.h"
#import "InviteTableViewCell.h"
#import "IMNetModel.h"
#import "UserModel.h"
@interface InviteTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataList;
@end

@implementation InviteTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.tableFooterView = [UIView new];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
        _dataList = [NSMutableArray array];
        [self getDataList];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"InviteTableViewCell";
    InviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"InviteTableViewCell" owner:self options:nil]firstObject];
    }
    UserModel *model = _dataList[indexPath.row];
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:nil];
    cell.titleLabel.text = model.nickName;
    cell.contentLabel.text = model.profession;
    [cell.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.rightButton.selected = model.isSelect;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 9, 150, 12)];
    label.text = @"为你推荐的名人";
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserModel *model = _dataList[indexPath.row];
    model.isSelect = !model.isSelect;
    [_dataList replaceObjectAtIndex:indexPath.row withObject:model];
    [self reloadData];
    if (self.inviewDelegate && [self.inviewDelegate respondsToSelector:@selector(getDataList:)]) {
        [self.inviewDelegate getDataList:_dataList];
    }

}

- (void)getDataList {
    UserModel *userModel = [UserModel getModel];
    [IMNetModel queryUserListWithUserId:userModel.userId success:^(id  _Nonnull responseObject) {
        NSArray *list = responseObject[@"content"];
        for (NSDictionary *dic in list) {
            UserModel *model = [UserModel mj_objectWithKeyValues:dic];
            [_dataList addObject:model];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)rightButtonClick: (UIButton *)button {
    InviteTableViewCell *cell = (InviteTableViewCell *)[[button superview]superview];
    NSIndexPath *index = [self indexPathForCell:cell];
    UserModel *model = _dataList[index.row];
    model.isSelect = !model.isSelect;
    [_dataList replaceObjectAtIndex:index.row withObject:model];
    [self reloadData];
    if (self.inviewDelegate && [self.inviewDelegate respondsToSelector:@selector(getDataList:)]) {
        [self.inviewDelegate getDataList:_dataList];
    }
}


@end
