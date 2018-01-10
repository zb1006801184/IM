//
//  IntroduceChatGroupViewController.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/18.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "IntroduceChatGroupViewController.h"
#import "UIViewController+SetNav.h"
@interface IntroduceChatGroupViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *introduceTextView;
@property (weak, nonatomic) IBOutlet UILabel *showMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *textNumbelLabel;

@end

@implementation IntroduceChatGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"介绍";
    [self initRightButton:@"保存"];
    [self initLeftBack];
}

- (void)rightButtonClick:(UIButton *)button {
    if (self.getIntroduceDataBlock) {
        self.getIntroduceDataBlock(self.introduceTextView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.showMessageLabel.hidden = YES;
    }else {
        self.showMessageLabel.hidden = NO;

    }
}





@end
