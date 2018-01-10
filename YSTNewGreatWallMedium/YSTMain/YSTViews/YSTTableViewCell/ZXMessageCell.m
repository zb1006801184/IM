//
//  ZXMessageCell.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/23.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "ZXMessageCell.h"

@implementation ZXMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
//        头像
        _avatarImageView = [[UIImageView alloc] init];
        [self addSubview:_avatarImageView];
     
//        消息背景
        _messageBackgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_messageBackgroundImageView];
        


    }
    
    return  self;
}

-(void)setModeldic:(NSMutableDictionary *)modeldic
{
    _modeldic = modeldic;
    float imageWidth = 40;
    
//    这个父类只处理头像、文字图片等消息在下面的子类处理
    if ([modeldic[@"type"] isEqualToString:@"1"]) {
        
        _avatarImageView.image = [UIImage imageNamed:@"头像"];
        _avatarImageView.frame = CGRectMake(kScreenWidth-10-imageWidth, 10, imageWidth, imageWidth);

        self.messageBackgroundImageView.image = [[UIImage imageNamed:@"message_sender_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
        
     
    }else if ([modeldic[@"type"] isEqualToString:@"2"]) {
        
        _avatarImageView.image = [UIImage imageNamed:@"Headimg"];

        _avatarImageView.frame = CGRectMake(10, 10, imageWidth, imageWidth);
        
        [self.messageBackgroundImageView setImage:[[UIImage imageNamed:@"message_receiver_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch]];

    }

   
}
- (void)setModel:(Chat *)model {
    _model = model;
    float imageWidth = 40;
    
    //    这个父类只处理头像、文字图片等消息在下面的子类处理
    if (model.type == 1) {
        
        _avatarImageView.image = [UIImage imageNamed:@"头像"];
        _avatarImageView.frame = CGRectMake(kScreenWidth-10-imageWidth, 10, imageWidth, imageWidth);
        
        self.messageBackgroundImageView.image = [[UIImage imageNamed:@"message_sender_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
        
        
    }else if (model.type == 2) {
        
        _avatarImageView.image = [UIImage imageNamed:@"Headimg"];
        
        _avatarImageView.frame = CGRectMake(10, 10, imageWidth, imageWidth);
        
        [self.messageBackgroundImageView setImage:[[UIImage imageNamed:@"message_receiver_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch]];
        
    }
}



@end
