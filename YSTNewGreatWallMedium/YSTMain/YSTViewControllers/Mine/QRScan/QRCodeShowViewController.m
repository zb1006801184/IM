//
//  QRCodeShowViewController.m
//  接入我的二维码
//
//  Created by 郭杰 on 2017/12/7.
//  Copyright © 2017年 郭杰. All rights reserved.
//

#import "QRCodeShowViewController.h"
#import "GJProduceTwoCode.h"


#define gWidth [UIScreen mainScreen].bounds.size.width
#define gHeight [UIScreen mainScreen].bounds.size.height

@interface QRCodeShowViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation QRCodeShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setShowViewUI];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.imageView.center = CGPointMake(gWidth / 2, gHeight / 2);
    
    UIImage *image = [GJProduceTwoCode codeWidthDataString:@"https://www.baidu.com" size:self.imageView.frame.size.width logo:@"sdfsdf"];
    
    self.imageView.image = image;
    
    [self.view addSubview:self.imageView];
    
    
}


-(void)setShowViewUI {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 27, 30, 30);
    [btn setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(gWidth/2-30, 27, 60, 30)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"我的二维码";
    [self.view addSubview:label];
    
}

- (void)btnBack
{
    UIViewController *vc = [self.navigationController popViewControllerAnimated:YES];
    if (!vc) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




#pragma mark  --  jlj

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
