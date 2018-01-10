//
//  HomeSegmentVideoCell.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "HomeSegmentVideoCell.h"
#import "NSString+TL.h"
@implementation HomeSegmentVideoCell

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
    _titlelabel.text = @"这是视频的的类型这是视频的的类型这是视频的的类型这是视频的的类型这是视频的的类型这是视频的的类型这是视频的的类型这是视频的的类型这是视频的的类型";
    _titlelabel.numberOfLines = 0;
    _titlelabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titlelabel];
    
    
    //    图片
    _bigimg = [[UIImageView alloc]init];
    _bigimg.backgroundColor = [UIColor redColor];
    [self addSubview:_bigimg];
    
    
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws).with.offset(10);
        make.left.equalTo(ws).with.offset(10);
        make.right.equalTo(ws.bigimg.mas_left).with.offset(-10);
        make.bottom.equalTo(ws).with.offset(-10);
        
    }];
    
    CGFloat imgh = 60;
    CGFloat imgw = 90;
    [_bigimg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws).with.offset(10);
        make.right.equalTo(ws).with.offset(-10);
        make.height.mas_equalTo(imgh);
        make.width.mas_equalTo(imgw);
//        make.centerYWithinMargins.mas_equalTo(ws);

    }];
    

//    判断label高度小于图片高度的时候。修改label高度和图片高度一样
    CGFloat titlelabelH = [_titlelabel.text contentHeightWithSize:15 width:kScreenWidth-30-imgw];
    DLog(@"%f",titlelabelH);
    if (titlelabelH < imgh) {
        
        //修改下边距约束
        [_titlelabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(ws).with.offset(10);
            make.left.equalTo(ws).with.offset(10);
            make.right.equalTo(ws.bigimg.mas_left).with.offset(-10);
            make.height.mas_equalTo(ws.bigimg);

        }];

    }
}



@end
