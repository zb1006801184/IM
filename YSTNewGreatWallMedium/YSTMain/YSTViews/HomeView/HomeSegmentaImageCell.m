//
//  HomeSegmentaImageCell.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "HomeSegmentaImageCell.h"

@implementation HomeSegmentaImageCell

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
    
//    内容
    _titlelabel = [[UILabel alloc]init];
    _titlelabel.numberOfLines = 0;
    _titlelabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titlelabel];


//    图片
    _bigimg = [[UIImageView alloc]init];
    _bigimg.backgroundColor = [UIColor redColor];
    [self addSubview:_bigimg];

 
    _titlelabel.text = @"这是一张图片的情况这是一张图片的情况这是一张图片的情况这是一张图片的情况这是一张图片的情况";
    WS(ws);
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws).with.offset(10);
        make.left.equalTo(ws).with.offset(10);
        make.bottom.equalTo(ws.bigimg.mas_top).with.offset(-10);
        make.right.equalTo(ws).with.offset(-10);
        
    }];
    
    [_bigimg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-10);
        make.right.equalTo(ws).with.offset(-10);
        make.height.mas_equalTo(120);
    }];

    
}










@end
