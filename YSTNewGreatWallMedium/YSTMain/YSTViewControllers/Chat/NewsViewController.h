//
//  NewsViewController.h
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/22.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDJViewController.h"

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *newstableView;
@property(nonatomic,strong) XYDJViewController * chatVC;

@property (nonatomic, assign) NSInteger type;

@end
