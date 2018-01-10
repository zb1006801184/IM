//
//  ZXChatMessageController.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/23.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "ZXChatMessageController.h"
#import "ZXTextMessageCell.h"
#import "ZXImageMessageCell.h"

@interface ZXChatMessageController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

@end

@implementation ZXChatMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = [NSMutableArray array];
    /**
     *  给tableView添加一个手势，点击手势回收 ChatBoxController 的键盘。。
     */
    [self.view addGestureRecognizer:self.tapGR];

    DLog(@"height1====%f",self.view.height);
    DLog(@"height2====%f",kScreenHeight - kNavHeight - 50);

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavHeight - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setTableFooterView:[UIView new]];
    
    [self.tableView registerClass:[ZXTextMessageCell class] forCellReuseIdentifier:@"ZXTextMessageCell"];//文字
//    [self.tableView registerClass:[ZXTextMessageCell class] forCellReuseIdentifier:@"ZXImageMessageCell"];//图片

}

#pragma mark - Public Methods
- (void) addNewMessage:(NSMutableDictionary *)message
{
    /**
     *  数据源添加一条消息，刷新数据
     */
    [self.data addObject:message];
    [self.tableView reloadData];
}
- (void)addMessageModel:(Chat *)model {
    [self.data addObject:model];
    [self.tableView reloadData];
}


- (void) scrollToBottom
{
    if (_data.count > 0) {
        // tableView 定位到的cell 滚动到相应的位置，后面的 atScrollPosition 是一个枚举类型
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_data.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    /**
     *  id类型的cell 通过取出来Model的类型，判断要显示哪一种类型的cell
     */
    id cell = [tableView dequeueReusableCellWithIdentifier:@"ZXTextMessageCell" forIndexPath:indexPath];
    // 给cell赋值
    NSMutableDictionary *dic = self.data[indexPath.row];
    Chat *model = self.data[indexPath.row];
    [cell setModel:model];
//    [cell setModeldic:dic];
   
    return cell;
    
}

#pragma mark - UITableViewCellDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static UILabel *label = nil;
    if (label == nil) {
        label = [[UILabel alloc] init];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:16.0f]];
    }
    Chat *model = _data[indexPath.row];
    NSString * text = model.content;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    [label setAttributedText:attrString];
    label.size = [label sizeThatFits:CGSizeMake(kScreenWidth * 0.58, MAXFLOAT)];
    return label.size.height + 40 > 60 ? label.size.height + 40 : 60;
}

#pragma mark - Getter
- (UITapGestureRecognizer *) tapGR
{
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    }
    return _tapGR;
}

#pragma mark - Event Response
- (void) didTapView
{
    if (_delegate && [_delegate respondsToSelector:@selector(didTapChatMessageView:)]) {
        
        [_delegate didTapChatMessageView:self];
        
    }
    
}
@end
