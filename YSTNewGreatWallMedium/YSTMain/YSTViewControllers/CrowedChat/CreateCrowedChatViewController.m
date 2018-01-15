//
//  CreateCrowedChatViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "CreateCrowedChatViewController.h"
#import "UIViewController+SetNav.h"
#import "CreateChatTanleView.h"
#import "IntroduceView.h"
#import "IntroduceChatGroupViewController.h"
#import "InviteMemberViewController.h"
#import "IMNetModel.h"
#import "UserModel.h"
//相机返回的结果  如果结果为0 则获取相机成功  为1  则获取相机失败   下边会有说明
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif
@interface CreateCrowedChatViewController ()<introduceDegelete,creatChatTableViewDegelete,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet CreateChatTanleView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, strong) IntroduceChatGroupViewController *introduceVC;//介绍控制器
@property (nonatomic, strong) InviteMemberViewController *inviteVC;//邀请控制器
@property (nonatomic, strong) IntroduceView *introduceView; //行业
@property (nonatomic, strong) NSString *groupNameStr;//群名称
@property (nonatomic, strong) NSString *introduceStr;//介绍
@property (nonatomic, strong) NSMutableDictionary *dataDic;//列表数据源
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (nonatomic,strong) NSString *imageUrl;
@end

@implementation CreateCrowedChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"创建群聊";
    [self initLeftBack];
    [self initRightButton:@"创建"];
    [self initViewWithTableView];
}
- (void)initViewWithTableView {
    self.myTableView.tableFooterView = self.footerView;
    self.myTableView.tableViewDegelete = self;
    self.introduceView = [[[NSBundle mainBundle]loadNibNamed:@"IntroduceView" owner:nil options:nil]firstObject];
    self.introduceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.introduceView.frame = self.view.bounds;
    self.introduceView.degelete = self;
    [self.view addSubview:self.introduceView];
    self.introduceView.hidden = YES;
    _dataDic = [NSMutableDictionary dictionary];
}
- (void)rightButtonClick:(UIButton *)button {
    [self createGroupChatNet];
}
#pragma mark - Net
//创建群
- (void)createGroupChatNet {
    NSArray *keys = [_dataDic allKeys];
    if (keys.count < 4) {
        [self.view makeToast:@"请完善群信息！" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (4 < _groupNameStr.length && _groupNameStr.length < 20) {
        [self.view makeToast:@"群名称4到20字！" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (_imageUrl.length < 1) {
        [self.view makeToast:@"图片正在上传..." duration:2 position:CSToastPositionCenter];
        return;
    }
    [IMNetModel createGroupChatWithUserId:[UserModel getModel].userId groupNumberByMax:@"100" groupType:@"2" groupName:_dataDic[@"zero"] descrbe:_dataDic[@"one"] topic:_dataDic[@"three"] imageUrl:_imageUrl groupUserType:@"2" success:^(id  _Nonnull responseObject) {
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
        [self initviteNetWithgroupId:responseObject[@"content"]];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
//邀请成员进群
- (void)initviteNetWithgroupId:(NSString *)groupId {
    [IMNetModel addGroupChatWithuserId:_dataDic[@"four"] groupId:groupId success:^(id  _Nonnull responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark -introduceDegelete
- (void)introduceViewCancle {
    self.introduceView.hidden = YES;
}
- (void)introduceViewSure {
    self.introduceView.hidden = YES;
    NSArray *list = [self.introduceView getAllSelectStrings];
    NSString *topic = @"";
    for (NSString *str in list) {
        topic = [NSString stringWithFormat:@"%@ %@",topic,str];
    }
    [self.dataDic setObject:topic forKey:@"three"];
    self.myTableView.dataDic = self.dataDic;
}
#pragma mark - chatTableViewDegelete
- (void)chatTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        //介绍
        if (!_introduceVC) {
            _introduceVC = [[IntroduceChatGroupViewController alloc]init];
        }
        __weak typeof(self)weakSelf= self;
        _introduceVC.getIntroduceDataBlock = ^(NSString *introduceStr) {
            if (introduceStr.length < 1) {
                return;
            }
            weakSelf.introduceStr = introduceStr;
            [weakSelf.dataDic setObject:introduceStr forKey:@"one"];
            weakSelf.myTableView.dataDic = weakSelf.dataDic;
        };
        [self.navigationController pushViewController:_introduceVC animated:YES];
    }else if (indexPath.row == 3) {
        //行业
        self.introduceView.hidden = NO;
        
    }else if (indexPath.row == 4) {
        //被邀请者
         _inviteVC = [[InviteMemberViewController alloc]init];
        __weak typeof(self)weakSelf = self;
        _inviteVC.inviteSelectBlock = ^(NSString *select) {
            if (select.length < 1) {
                return ;
            }
            [weakSelf.dataDic setObject:select forKey:@"four"];
            weakSelf.myTableView.dataDic = weakSelf.dataDic;
        };
        [self.navigationController pushViewController:_inviteVC animated:YES];
    }
}

- (void)textfieldEnd:(UITextField *)textField {
    if (textField.text.length < 1) {
        return;
    }
    _groupNameStr = textField.text;
    [_dataDic setObject:textField.text forKey:@"zero"];
}

- (IBAction)selectPhotoClick:(id)sender {
    [self changePhoto];
}

-(void)changePhoto
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //等于0 则说明获取相机成功
        if(SIMULATOR == 0){
            /**
             其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
             */
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式:通过相机
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            PickerImage.allowsEditing = YES;
            PickerImage.delegate = self;
            [self presentViewController:PickerImage animated:YES completion:nil];
        }
        
        if(SIMULATOR == 1){
            UIAlertController *alertpz = [UIAlertController alertControllerWithTitle: @"" message:@"模拟器上没有照相机!" preferredStyle:UIAlertControllerStyleAlert];
            [alertpz addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertpz animated:YES completion:nil];
            
        }
    }
                      ]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法  取出图片  实现赋值
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //self.imgV.image = newPhoto;
    [self.selectPhotoButton setImage:newPhoto forState:UIControlStateNormal];
    NSData *imageData = UIImagePNGRepresentation(newPhoto);
    [self postPhoto:imageData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)postPhoto:(NSData *)data {
    [IMNetModel filedUploadWithData:data type:@"png" success:^(id  _Nonnull responseObject) {
        _imageUrl = responseObject[@"content"];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


@end
