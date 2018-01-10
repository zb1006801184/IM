//
//  HomeSegmentImagesCell.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "HomeSegmentImagesCell.h"

@implementation HomeSegmentImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        ui布局
        [self initview];
        
    }
    return self;
}


-(void)initview{
    
    WS(ws);
    //    内容
    _titlelabel = [[UILabel alloc]init];
    _titlelabel.text = @"这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况这是三张图片的情况";
    _titlelabel.numberOfLines = 0;
    _titlelabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titlelabel];
    
    
    //    左边图片
    _leftimg = [[UIImageView alloc]init];
    _leftimg.backgroundColor = [UIColor redColor];
    [self addSubview:_leftimg];
    
    
    //    中间图片
    _centreimg = [[UIImageView alloc]init];
    _centreimg.backgroundColor = [UIColor blueColor];
    [self addSubview:_centreimg];
    
    
    
    //    右边图片
    _rightimg = [[UIImageView alloc]init];
    _rightimg.backgroundColor = [UIColor orangeColor];
    [self addSubview:_rightimg];
    

    
    
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(ws).with.offset(10);
        make.left.equalTo(ws).with.offset(10);
        make.bottom.equalTo(ws.leftimg.mas_top).with.offset(-10);
        make.right.equalTo(ws).with.offset(-10);

    }];
    
//    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:_leftimg];
//    [arr addObject:_centreimg];
//    [arr addObject:_rightimg];
//    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:10 tailSpacing:10];
//    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(ws.titlelabel.mas_bottom).with.offset(10);
//        make.height.mas_equalTo(120);
//    }];


    [_leftimg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(ws).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-10);
        make.height.mas_equalTo(150);


    }];

    [_centreimg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.height.and.width.equalTo(ws.leftimg);
        make.left.equalTo(ws.leftimg.mas_right).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-10);


    }];

    [_rightimg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.height.and.width.equalTo(ws.leftimg);
        make.left.equalTo(ws.centreimg.mas_right).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-10);
        make.right.equalTo(ws).with.offset(-10);
//        make.height.mas_equalTo(_leftimg.width).multipliedBy(0.6);// 高/宽 == 0.6


    }];
    
}


@end
