//
//  GJBrowRaiseV.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJBrowRaiseV.h"
#import "GJBrowMaCell.h"

@interface GJBrowRaiseV ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation GJBrowRaiseV

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self loadData];
        [self initializa];
    }
    
    return self;
}

- (void)loadData
{
    _dataArray = [@[@"f_static_000", @"emoji_1_big", @"section0_emotion2"] mutableCopy];
}

- (void)initializa
{
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnWidth = 30;
    //添加按钮
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, (self.height-btnWidth)/2, btnWidth, btnWidth)];
    addBtn.backgroundColor = [UIColor whiteColor];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBrowAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    
    //设置按钮
    UIButton *setBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-btnWidth-10, 0, btnWidth, btnWidth)];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setBtn];
    
    
    GJCVFlowLayout *flowLayout = [[GJCVFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(40, self.height);
    
    _browMaV = [[UICollectionView alloc] initWithFrame:CGRectMake(addBtn.right, 0, self.width-2*btnWidth-20, self.height) collectionViewLayout:flowLayout];
    _browMaV.backgroundColor = [UIColor whiteColor];
    _browMaV.delegate = self;
    _browMaV.dataSource = self;
    [self addSubview:_browMaV];
    
    [_browMaV registerClass:[GJBrowMaCell class] forCellWithReuseIdentifier:@"GJBrowMaCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJBrowMaCell *maCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GJBrowMaCell" forIndexPath:indexPath];

    maCell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.row]];
//    maCell.selected = YES;
    return maCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    self.pageIndex = [NSString stringWithFormat:@"%ld", indexPath.row];
    NSLog(@"self.index --- %@", self.pageIndex);
}


#pragma mark - 添加按钮
- (void)addBrowAction:(UIButton *)button
{
    NSLog(@"添加按钮");
}

#pragma mark - 设置按钮
- (void)settingAction:(UIButton *)button
{
    NSLog(@"设置按钮");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
