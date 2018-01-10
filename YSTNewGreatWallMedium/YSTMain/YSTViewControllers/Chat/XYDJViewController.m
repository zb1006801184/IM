//
//  XYDJViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/22.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "XYDJViewController.h"
#import "GJKeyboard.h"
#import "ZXChatMessageController.h"
#import "GJTextView.h"
#import "YSTCommonTools.h"
#import "YSTSocketTool.h"
#import "ChatUserMessageViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>


@interface XYDJViewController ()<GJKeyboardDelegate,ZXChatMessageControllerDelegate,SocketDelegate>
@property (nonatomic,strong) GJKeyboard *keyBoard;
@property(nonatomic,strong)ZXChatMessageController * chatMessageVC;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation XYDJViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.userModel.userId;
    UIBarButtonItem * barButton= [[UIBarButtonItem alloc]initWithCustomView:self.backbutton];
    self.navigationItem.leftBarButtonItem = barButton;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    _chatMessageVC = [[ZXChatMessageController  alloc] init];
    [_chatMessageVC.view setFrame:CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight - kNavHeight - 50)];
    [self.view addSubview:_chatMessageVC.view];
    _chatMessageVC.delegate = self;
    
    _keyBoard = [[GJKeyboard alloc] initWithFrame:CGRectMake(0, self.view.height - 50, self.view.width, 50)];
    _keyBoard.delegate = self;
    [self.view addSubview:_keyBoard];
    [self socket];
    [self messageListNet];
 
}

- (void)socket {
    YSTSocketTool *socketTool = [YSTSocketTool ShareSocketTool];
    socketTool.detegate = self;
    [socketTool startConnect];
}


#pragma mark - GJTextViewDelegate
-(void)sendMessageText:(NSString *)message {
    
//    返回键盘输出的值
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:message forKey:@"content"];
    [params setObject:@"1" forKey:@"type"];
    Chat *chatModel = [Chat mj_objectWithKeyValues:params];
    chatModel.type = 1;
    [self.chatMessageVC addMessageModel:chatModel];
    
    UserModel *model = [UserModel getModel];
    NSDictionary *test = @{@"accepteId":self.userModel.userId,@"senderId":model.userId,@"content":message,@"event":@"1"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:test options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonStr = [NSString stringWithFormat:@"%lu   %@",(unsigned long)jsonStr.length,jsonStr];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];

    //发送消息
    [[YSTSocketTool ShareSocketTool]sendMessageWithData:data];
    
    [self.chatMessageVC scrollToBottom];


}
-(void)sendMessageTextheight:(CGFloat)messageheight
{
    //    返回键盘的高度
    _chatMessageVC.view.height = kScreenHeight - kNavHeight - messageheight - 50;
    _chatMessageVC.tableView.height = _chatMessageVC.view.height;
    [self.chatMessageVC scrollToBottom];
}

//返回按钮
-(UIButton * )backbutton
{
    if (!_backbutton)
    {
        
        _backbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_backbutton setTitle:@"返回" forState:UIControlStateNormal];
        _backbutton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_backbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _backbutton.frame = CGRectMake(0, 0, 60, 30);
        [_backbutton addTarget:self action:@selector(ReturnCick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _backbutton;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"用户" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(0, 0, 60, 30);
        [_rightBtn addTarget:self action:@selector(ReturnCick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightBtn;
}

-(void)ReturnCick:(UIButton *)button
{
    if (_backbutton == button) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_rightBtn == button) {
        ChatUserMessageViewController *user = [[ChatUserMessageViewController alloc]init];
        user.userModel = self.userModel;
        [self.navigationController pushViewController:user animated:YES];
    }
    
    
}

/**
 * TLChatMessageViewControllerDelegate 的代理方法
 */
#pragma mark - TLChatMessageViewControllerDelegate
- (void) didTapChatMessageView:(ZXChatMessageController *)chatMessageViewController
{
    DLog(@"收键盘");
    [self.keyBoard.textView resignFirstResponder];
    
//    _chatMessageVC.view.height = kScreenHeight - kNavHeight - 50;
//    _chatMessageVC.tableView.height = _chatMessageVC.view.height;
//    [self.chatMessageVC scrollToBottom];


}
#pragma mark -SocketDelegate
- (void)readDataWithMessage:(NSData *)data {
    
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
//  NSString *text =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:dic[@"content"] forKey:@"content"];
    [params setObject:@"2" forKey:@"type"];
//    [self.chatMessageVC addNewMessage:params];
    
    Chat *model = [Chat mj_objectWithKeyValues:dic];
    if ([model.event integerValue] == 0) {
        return;
    }
    model.type = 2;
    [self.chatMessageVC addMessageModel:model];
    [self.chatMessageVC scrollToBottom];
}
#pragma mark - messageListNet
- (void)messageListNet {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userModel.userId forKey:@"senderId"]; //
    [params setObject:@"" forKey:@"accepteId"];
    [params setObject:@"10" forKey:@"pageSize"];
    [params setObject:@"1" forKey:@"pageNumber"];

    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_GETHISTORYMESSAGE option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0) {
           NSArray *listAry = responseObject[@"content"];
            for (NSDictionary *dic in listAry ) {
                Chat *model = [Chat mj_objectWithKeyValues:dic];
                model.type = 2;
                [self.chatMessageVC addMessageModel:model];
                [self.chatMessageVC scrollToBottom];
            }
        }
        [self.view makeToast:mainModel.msg duration:2 position:CSToastPositionCenter];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
