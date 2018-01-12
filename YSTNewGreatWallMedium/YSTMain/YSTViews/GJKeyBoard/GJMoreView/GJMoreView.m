//
//  GJMoreView.m
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import "GJMoreView.h"
#import "GJMoreCell.h"


#import "LocalViewController.h"

@interface GJMoreView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *imgArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation GJMoreView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initializa];
    }
    
    return self;
}

- (void)initializa
{
    _imgArray = @[@"icon_news_more_photo", @"icon_news_more_shoot",];
    _titleArray = @[@"图片",@"相机"];
    
    
    GJCVFlowLayout *flowLayout = [[GJCVFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.width / 4.0, self.width / 4.0);
    
    _moreCV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _moreCV.backgroundColor = rColor(237, 237, 246);
    _moreCV.delegate = self;
    _moreCV.dataSource = self;
    [self addSubview:_moreCV];
    
    [_moreCV registerClass:[GJMoreCell class] forCellWithReuseIdentifier:@"GJMoreCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imgArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJMoreCell *moreCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GJMoreCell" forIndexPath:indexPath];
    moreCell.imgView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    moreCell.titleLabel.text = _titleArray[indexPath.row];
    return moreCell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 2) {
        
//
//        LocalViewController *localVC = [[LocalViewController alloc] init];
//
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:localVC];
//
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{

//        }];
        
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
