//
//  ApplyGroupListTableView.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/21.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "ApplyGroupListTableView.h"
#import "InviteTableViewCell.h"
#import "ChatListTableViewCell.h"
@interface ApplyGroupListTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ApplyGroupListTableView
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
@end

