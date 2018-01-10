//
//  ZXTextMessageCell.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/24.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "ZXTextMessageCell.h"
#import "Chat.h"
@implementation ZXTextMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _messageTextLabel = [[UILabel alloc] init];
        [_messageTextLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_messageTextLabel setNumberOfLines:0];
        [self addSubview:_messageTextLabel];
    }
    return self;
}

-(void)setModeldic:(NSMutableDictionary *)modeldic
{
    [super setModeldic:modeldic];


    NSString *textstr = modeldic[@"text"];
    NSAttributedString *attrString = [self formatMessageString:textstr];
    [self.messageTextLabel setAttributedText:attrString];
    self.messageTextLabel.size = [self.messageTextLabel sizeThatFits:CGSizeMake(kScreenWidth * 0.58, MAXFLOAT)];
    

    
    /**
     *  Label 的位置根据头像的位置来确定
     */
    if ([modeldic[@"type"] isEqualToString:@"1"]) {
        
        //        _messageTextLabel.frame = CGRectMake(kScreenWidth-10-imageWidth-200, 10, imageWidth, imageWidth);
        float y = self.avatarImageView.origin.y + 11;
        float x = self.avatarImageView.origin.x - self.messageTextLabel.width - 27;
        [self.messageTextLabel setOrigin:CGPointMake(x, y)];
        
        x -= 18;                                    // 左边距离头像 5
        y = self.avatarImageView.origin.y - 5;       // 上边与头像对齐 (北京图像有5个像素偏差)
        float h = MAX(self.messageTextLabel.height + 30, self.avatarImageView.height + 10);
        
        [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.messageTextLabel.width + 40, h)];
        
        
    }else if ([modeldic[@"type"] isEqualToString:@"2"]){
        

        //        _messageTextLabel.frame = CGRectMake(10+imageWidth+10, 10, imageWidth, imageWidth);
        float y = self.avatarImageView.origin.y + 11;
        float x = self.avatarImageView.origin.x + self.avatarImageView.width + 23;
        [self.messageTextLabel setOrigin:CGPointMake(x, y)];
        
        x -= 18;                                    // 左边距离头像 5
        y = self.avatarImageView.origin.y - 5;       // 上边与头像对齐 (北京图像有5个像素偏差)
        float h = MAX(self.messageTextLabel.height + 30, self.avatarImageView.height + 10);
        
        [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.messageTextLabel.width + 40, h)];
        
    }
    
}

- (void)setModel:(Chat *)model {
    [super setModel:model];
    
    
    NSString *textstr = model.content;
    NSAttributedString *attrString = [self formatMessageString:textstr];
    [self.messageTextLabel setAttributedText:attrString];
    self.messageTextLabel.size = [self.messageTextLabel sizeThatFits:CGSizeMake(kScreenWidth * 0.58, MAXFLOAT)];
    
    
    
    /**
     *  Label 的位置根据头像的位置来确定
     */
    if (model.type == 1) {
        
        //        _messageTextLabel.frame = CGRectMake(kScreenWidth-10-imageWidth-200, 10, imageWidth, imageWidth);
        float y = self.avatarImageView.origin.y + 11;
        float x = self.avatarImageView.origin.x - self.messageTextLabel.width - 27;
        [self.messageTextLabel setOrigin:CGPointMake(x, y)];
        
        x -= 18;                                    // 左边距离头像 5
        y = self.avatarImageView.origin.y - 5;       // 上边与头像对齐 (北京图像有5个像素偏差)
        float h = MAX(self.messageTextLabel.height + 30, self.avatarImageView.height + 10);
        
        [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.messageTextLabel.width + 40, h)];
        
        
    }else if (model.type == 2){
        
        
        //        _messageTextLabel.frame = CGRectMake(10+imageWidth+10, 10, imageWidth, imageWidth);
        float y = self.avatarImageView.origin.y + 11;
        float x = self.avatarImageView.origin.x + self.avatarImageView.width + 23;
        [self.messageTextLabel setOrigin:CGPointMake(x, y)];
        
        x -= 18;                                    // 左边距离头像 5
        y = self.avatarImageView.origin.y - 5;       // 上边与头像对齐 (北京图像有5个像素偏差)
        float h = MAX(self.messageTextLabel.height + 30, self.avatarImageView.height + 10);
        
        [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.messageTextLabel.width + 40, h)];
        
    }
}

//把表情转换成文字属性
- (NSAttributedString *) formatMessageString:(NSString *)text
{
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
//        NSLog(@"%@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        
        //获取数组元素中得到range
        NSRange range = [match range];
//        //获取原字符串中对应的值
        NSString *subStr = [text substringWithRange:range];
        
        NSString *Path = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:Path];
        
        for (NSString *str in data.allKeys) {

            if ([str isEqualToString:subStr]) {

                //face[i][@"png"]就是我们要加载的图片
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = [UIImage imageNamed:data[str]];

                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -4, 20, 20);
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
                
            }
        }

        
    }
    

    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
    
}

@end
