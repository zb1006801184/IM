//
//  YSTMineViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTMineViewController.h"
#import "GJView.h"
#import "ModelarCollectionView.h"
#import "DQModel.h"
#import "DQTool.h"
#import "CollectionViewCell.h"
#import "NewsViewController.h"


#import "QRScanViewController.h"


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kTopPictureHeight 120

//每个格子的高度
#define GridHeight 122
//每行显示格子的列数
#define PerRowGridCount 3
//每个格子的宽度
#define GridWidth ((kScreenWidth - 40)/PerRowGridCount-4)



@interface YSTMineViewController ()<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,RTDragCellTableViewDataSource,RTDragCellTableViewDelegate,LeftButtonDelegate,QRScanDelegate>

@property (nonatomic, strong) GJView *scrollV;


@property (nonatomic, strong) ModelarCollectionView *DQCollectionView;

@property (nonatomic, strong) NSMutableArray <DQModel *> *DataArr;
//展示框
@property (strong, nonatomic) IBOutlet UIView *showBoxView;

@property (weak, nonatomic) IBOutlet UITextField *useridTextField;


@end

@implementation YSTMineViewController



- (IBAction)sureClick:(id)sender {
    [self addNet];
}

- (IBAction)cancleClick:(id)sender {
    self.showBoxView.hidden = YES;
}




#pragma mark - 二维码
-(void)qRCodeButton {
    
    QRScanViewController *QRVC = [[QRScanViewController alloc] init];
    
    QRVC.delegate = self;
    
    
    //     隐藏底部工具栏
    QRVC.hidesBottomBarWhenPushed = YES;
    
    NSLog(@"时代峻峰老司机独领风骚的");
    
    [self showViewController:QRVC sender:nil];
    
}


-(void)qrScanResult:(NSString *)result viewController:(QRScanViewController *)qrScanVC {
    
    //    [qrScanVC.navigationController popViewControllerAnimated:NO];
    
    NSLog(@"扫描的结果是 ： %@",result);
    //    ResultViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ResultViewController"];
    //    vc.result = result;
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self showViewController:vc sender:nil];
    
}




-(void)rightSettingButtonClick {
    
    NSLog(@"99999999999");
 
    
    
    
   
    
    
}


-(void)leftButtonClick {
    
    NSLog(@"000000000000");
    
    
    UIViewController *VC = [[UIViewController alloc] init];
    
    self.showBoxView.hidden = NO;
    
    
}


- (void)addNet {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UserModel *model = [UserModel getModel];
    if (self.useridTextField.text.length < 1) {
        return;
    }
    [params setObject:model.userId forKey:@"user_id"];
    [params setObject:self.useridTextField.text forKey:@"add_user_id"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_ADDUSERCHATS option:IPHNetWorkHelperOptionPOST parameters:params data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        self.showBoxView.hidden = YES;
        [self.view makeToast:responseObject[@"msg"] duration:2 position:CSToastPositionCenter];
    } failure:^(NSError * _Nonnull error) {

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    self.scrollV = [[GJView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    
    
    self.scrollV.scrollView.delegate = self;
    
    self.scrollV.delegate = self;
    
    
    [self.view addSubview:self.scrollV];
    
    
    
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init] ;
    flowLayout.itemSize = CGSizeMake(GridWidth, GridHeight) ;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical ;
    
    
    self.DQCollectionView = [[ModelarCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.scrollV.bottomView.bounds.size.width, self.scrollV.bottomView.bounds.size.height) collectionViewLayout:flowLayout] ;
    [self.DQCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"] ;
    self.DQCollectionView.delegate = self ;
    self.DQCollectionView.dataSource = self ;
    self.DQCollectionView.adelegate = self ;
    self.DQCollectionView.adataSource = self ;
    self.DQCollectionView.alwaysBounceVertical = YES;
    self.DQCollectionView.bounces = NO;
    
    
    [self.scrollV.bottomView addSubview:self.DQCollectionView] ;
    self.DQCollectionView.backgroundColor = [UIColor whiteColor];
    
    NSArray *Arr = @[@"0",@"1",@"2",@"3",@"4",@"7",@"8",@"9"];//假如 这是后面返回 要显示的内容
    
    NSArray *array = [DQTool InitializeDateFunction:Arr];
    self.DataArr = [array mutableCopy];
    [self.DQCollectionView reloadData];
    
    
    
    self.showBoxView.frame = CGRectMake(0, 220, kScreenWidth, 220);
    [self.view addSubview:self.showBoxView];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (NSMutableArray<DQModel *> *)DataArr{
    if (!_DataArr) {
        _DataArr = [NSMutableArray new];
    }
    
    return _DataArr;
}





- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.DataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] ;
    [cell SetDataFromModel:self.DataArr[indexPath.row]];
    return cell ;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(GridWidth, GridHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击事件
    DQModel *model = self.DataArr[indexPath.row];
    NewsViewController *messageListVC = [[NewsViewController alloc]init];
    if ([model.title isEqualToString:@"消息列表"]) {
        messageListVC.type = 1;
        [self.navigationController pushViewController:messageListVC animated:YES];
    }else if ([model.title isEqualToString:@"好友列表"]){
        messageListVC.type = 2;
        [self.navigationController pushViewController:messageListVC animated:YES];
    }
}
- (void)tableView:(ModelarCollectionView *)tableView newArrayDataForDataSource:(NSArray *)newArray{
    //改变数组
    self.DataArr = [NSMutableArray arrayWithArray:newArray] ;
    
}
/**选中的cell完成移动，手势已松开*/
- (void)cellDidEndMovingInTableView:(ModelarCollectionView *)tableView{
    //保存数据
    [DQTool SaveUserDefaultsDataFunction:self.DataArr];
    
}
- (NSArray *)originalArrayDataForTableView:(ModelarCollectionView *)tableView{
    
    return self.DataArr;
}







- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    
    NSLog(@"打印数据 ： %lf",point.y);
    
    // 偏移量y的变化
    CGFloat dy = scrollView.contentOffset.y;
    NSLog(@"%f", dy);
    // 判断拉倒方向
    if (dy < 0) {
        // 利用公式
        self.scrollV.imageView.frame =CGRectMake(0, dy,kScreenWidth, kTopPictureHeight - dy);
    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
