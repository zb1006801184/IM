//
//  RootViewController.m
//  UUChatTableView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "RootViewController.h"
#import "UUInputFunctionView.h"
#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import "UIViewController+SetNav.h"
#import "CrowedChatDetailsViewController.h"
#import "YSTSocketTool.h"
#import "UserModel.h"
#import "IMNetModel.h"
@interface RootViewController ()<UUInputFunctionViewDelegate,UUMessageCellDelegate,UITableViewDataSource,UITableViewDelegate,SocketDelegate>

@property (strong, nonatomic) MJRefreshHeader *head;
@property (strong, nonatomic) ChatModel *chatModel;

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation RootViewController{
    UUInputFunctionView *IFView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _model.groupName;
    [self initBar];
    [self addRefreshViews];
    [self loadBaseViewsAndData];
    [self socket];
}
- (void)socket {
    YSTSocketTool *socketTool = [YSTSocketTool ShareSocketTool];
    socketTool.detegate = self;
    [socketTool startConnect];
}
#pragma mark - SocketDelegate
//长连接  接收到了数据
- (void)readDataWithMessage:(NSData *)data {
    //防止接收到空数据
    if (!data) {
        return;
    }

    NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    jsonString = [jsonString substringFromIndex:4];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"2" forKey:@"types"];
    if ([dic[@"event"] integerValue] == 2||[dic[@"event"] integerValue] == -1) {
        //不是接收的消息
        return;
    }
    if (_ChatType == ChatWithChat) {
        //有群id的  群聊
        NSString *groupChat = dic[@"groupId"];
        if (groupChat.length > 0) {
            return;
        }
        //单聊
        if ([dic[@"senderId"] integerValue] != [_userModel.accepteId integerValue]) {
            //不属于自己的信息
            return;
        }
    }else {
        //群聊
        if ([dic[@"groupId"] integerValue ] != _model.id) {
            //不是本群的消息
            return;
        }
        
    }
  
    //文本消息
    if ([dic[@"type"] integerValue] == 0 || [dic[@"type"] integerValue] == -1) {
        [params setObject:dic[@"content"] forKey:@"strContent"];
        [params setObject:dic[@"nickName"] forKey:@"nickName"];
        [self.chatModel addSpecifiedItem:params];
        [self.chatTableView reloadData];
        [self tableViewScrollToBottom];
        return;
    }
    //图片消息
    if ([dic[@"type"] integerValue] == 2) {
        //先下载
        [[[SDWebImageManager sharedManager] imageDownloader]downloadImageWithURL:[NSURL URLWithString:dic[@"content"]] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            //再显示
            [params setObject:image forKey:@"picture"];
            [params setObject:dic[@"nickName"] forKey:@"nickName"];
            [params setObject:@(UUMessageTypePicture) forKey:@"type"];
            [self.chatModel addSpecifiedItem:params];
            [self.chatTableView reloadData];
            [self tableViewScrollToBottom];
        }];
        return;
    }
    //语音消息
    if ([dic[@"type"] integerValue] == 6) {
        dispatch_async(dispatch_queue_create("playSoundFromUrl", NULL), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"content"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [params setObject:data forKey:@"voice"];
                [params setObject:dic[@"nickName"] forKey:@"nickName"];
                [params setObject:[NSString stringWithFormat:@"%ld",data.length/4064] forKey:@"strVoiceTime"];
                [params setObject:@(UUMessageTypeVoice) forKey:@"type"];
                [self.chatModel addSpecifiedItem:params];
                [self.chatTableView reloadData];
                [self tableViewScrollToBottom];
            });
        });
        return;
    }
  
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)initBar
{
//    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@" private ",@" group "]];
//    [segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
//    segment.selectedSegmentIndex = 0;
//    self.navigationItem.titleView = segment;
//    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    [self initLeftBack];
    [self initRight];
}
- (void)initRight {
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [rightButton setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
    [rightButton setTitle:@"详情" forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents: UIControlEventTouchUpInside];
}
- (void)rightButtonClick:(UIButton *)button {
    CrowedChatDetailsViewController *groupVC = [[CrowedChatDetailsViewController alloc]init];
    groupVC.model = _model;
    [self.navigationController pushViewController:groupVC animated:YES];
}
- (void)leftButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)segmentChanged:(UISegmentedControl *)segment
{
    self.chatModel.isGroupChat = segment.selectedSegmentIndex;
    [self.chatModel.dataSource removeAllObjects];
    [self.chatModel populateRandomDataSource];
    [self.chatTableView reloadData];
}

- (void)addRefreshViews
{
    __weak typeof(self) weakSelf = self;
    
    //load more
    int pageNum = 3;
    
//    _head = [MJRefreshHeader header];
//    _head.scrollView = self.chatTableView;
//    _head.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
//        
//        [weakSelf.chatModel addRandomItemsToDataSource:pageNum];
//        
//        if (weakSelf.chatModel.dataSource.count > pageNum) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.chatTableView reloadData];
//                [weakSelf.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            });
//        }
//        [weakSelf.head endRefreshing];
//    };
}

- (void)loadBaseViewsAndData
{
    self.chatModel = [[ChatModel alloc]init];
    self.chatModel.isGroupChat = YES;
    [self.chatModel populateRandomDataSource];
    
    IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    IFView.delegate = self;
    [self.view addSubview:IFView];
    
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    //adjust ChatTableView's height
    if (notification.name == UIKeyboardWillShowNotification) {
        self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
    }else{
        self.bottomConstraint.constant = 40;
    }
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    CGRect newFrame = IFView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    IFView.frame = newFrame;
    
    [UIView commitAnimations];
    
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.chatModel.dataSource.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - InputFunctionViewDelegate
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
    //判断是否被禁言
    if (_model.isProhibit) {
        //被禁言(停止发言)
        [self.view makeToast:@"已被禁言!!!" duration:2 position:CSToastPositionCenter];
        return;
    }
    
    NSDictionary *dic = @{@"strContent": message,
                          @"type": @(UUMessageTypeText)};
    funcView.TextViewInput.text = @"";
    [funcView changeSendBtnWithPhoto:YES];
    [self dealTheFunctionData:dic];
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image
{
    NSDictionary *dic = @{@"picture": image,
                          @"type": @(UUMessageTypePicture)};
    [self dealTheFunctionData:dic];
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    [self uploadImge:data];
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    NSDictionary *dic = @{@"voice": voice,
                          @"strVoiceTime": [NSString stringWithFormat:@"%d",(int)second],
                          @"type": @(UUMessageTypeVoice)};
    [self uploadVoice:voice];
    [self dealTheFunctionData:dic];
}

- (void)UUInputFunctionViewClickMore {
    CGRect newFrame = IFView.frame;
    IFView.moreView.hidden = !IFView.moreView.hidden;
    if (!IFView.moreView.hidden) {
        newFrame.origin.y = kScreenHeight - 216 - newFrame.size.height;
    }else {
        newFrame.origin.y = kScreenHeight  - newFrame.size.height;
    }
    IFView.frame = newFrame;
}

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    if ([dic[@"type"] integerValue] == UUMessageTypeText) {
        //文本消息
        [self sendMessageText:dic[@"strContent"] type:@"0"];
    }else if ([dic[@"type"] integerValue]) {
        //图片消息
        
    }
    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    IFView.moreView.hidden = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
//点击头像
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.messageFrame.message.strName message:@"headImage clicked" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [alert show];
}
- (void)cellContentDidClick:(UUMessageCell *)cell image:(UIImage *)contentImage {
    IFView.moreView.hidden = YES;
}
//发送消息（给服务器）
-(void)sendMessageText:(NSString *)message type:(NSString *)type {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:message forKey:@"strContent"];
    [params setObject:@"1" forKey:@"types"];
    BOOL isGroupChat = true;
    //接受者ID
    NSString *accepteId  = [NSString stringWithFormat:@"%ld",_model.id];
    //接受者ID
    NSString *event = @"3";
    //是否是群聊
    switch (_ChatType) {
        case ChatWithChat:
            isGroupChat = false;
            accepteId = _userModel.accepteId;
            event = @"1";
            break;
        default:
            break;
    }
    
    //event
    NSDictionary *test = @{@"accepteId":accepteId,@"senderId":[UserModel getModel].userId,@"content":message,@"event":event,@"type":type,@"isGroupChat":@(isGroupChat),@"occureTime":@"1515034889568",@"requestSourceSystem":@"app",@"version":@"1515034889568",@"id":@"1515034889568",@"nickName":[UserModel getModel].nickName,@"portrait":@""};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:test options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonStr = [NSString stringWithFormat:@"%lu   %@",(unsigned long)jsonStr.length,jsonStr];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    //发送消息
    [[YSTSocketTool ShareSocketTool]sendMessageWithData:data];
}
#pragma mark - net
//上传图片
- (void)uploadImge:(NSData *)data {
    [IMNetModel filedUploadWithData:data type:@"png" success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            //上传成功发送图片消息
            [self sendMessageText:responseObject[@"content"] type:@"2"];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
//上传语音消息
- (void)uploadVoice:(NSData *)data {
    [IMNetModel filedUploadWithData:data type:@"amr" success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
           //上次成功 发送语音消息
            [self sendMessageText:responseObject[@"content"] type:@"6"];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
