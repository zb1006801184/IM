//
//  HomeSegmenttextCell.m
//  YSTNewGreatWallMedium
//
//  Created by yongzeng on 2017/11/30.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "HomeSegmenttextCell.h"

@implementation HomeSegmenttextCell

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
    

    
    
    _titlelabel.text = @"这是无图的情况这是无图的情况这是无图的情况这是无图的情况这是无图的情况这是无图的情况";
    WS(ws);
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws).with.offset(10);
        make.left.equalTo(ws).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-10);
        make.right.equalTo(ws).with.offset(-10);
        
    }];

    
    
}


@end
