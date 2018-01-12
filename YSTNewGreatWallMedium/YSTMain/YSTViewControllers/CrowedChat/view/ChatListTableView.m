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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"ChatListTableViewCell";
    ChatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChatListTableViewCell" owner:self options:nil]firstObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    [self reloadData];
}

@end

