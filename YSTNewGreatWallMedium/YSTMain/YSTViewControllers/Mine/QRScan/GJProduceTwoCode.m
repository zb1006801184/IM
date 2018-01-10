//
//  GJProduceTwoCode.m
//  二维码
//
//  Created by 郭杰 on 2017/12/4.
//  Copyright © 2017年 郭杰. All rights reserved.
//

#import "GJProduceTwoCode.h"


static CGFloat pro = 5.0;

@implementation GJProduceTwoCode


/**
 创建二维码
 参数1：二维码目标字符串
 参数2：指定生成的大小size - 建议size的大小传imageView的大小
 参数3：添加的logo（可以为nil） - 其中logo的大小为size的5.0（默认， 也可以去修改pro）
 */
+ (UIImage *)codeWidthDataString:(NSString *)TargetString size:(CGFloat)size logo:(NSString *)logoName {
    
    //1、创建过滤器
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //2、过滤器恢复默认
    [filter setDefaults];
    //3、给过滤器添加数据（数据要转化成UTF8）
    NSData *data = [TargetString dataUsingEncoding:NSUTF8StringEncoding];
    //4、通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //5、获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    
//    画出二维码
    UIImage *targeImage = [self createNonInterpolatedUIimaegFormCIImage:outputImage withSize:size logo:(logoName != nil ? logoName : nil)];
    
    return targeImage;
    
    
    
}


#pragma mark - 根据参数画出二维码
+ (UIImage *)createNonInterpolatedUIimaegFormCIImage:(CIImage *)image withSize:(CGFloat)size logo:(NSString *)logoName{
    
//    获取图片的frame值，转换
    CGRect extent = CGRectIntegral(image.extent);
//     设置比例
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    //1、创建bitMap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
//    创建图形上下文
//     设置渐变空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    创建图形上下文空间
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2、保存bitImage图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //生成logo
    BOOL logo = logoName != nil ? YES : NO;
    if (logo) {
        UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
        [outputImage drawInRect:CGRectMake(0, 0, size, size)];
        UIImage *waterImage = [UIImage imageNamed:logoName];
        //注意：logo不能太大（最大不能超过二维码图片的30%），否则扫描不出来
        [waterImage drawInRect:CGRectMake((size - size / pro) / 2., (size - size / pro) / 2., size / pro, size / pro)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        outputImage = newImage;
    }
    
    return outputImage;
}













@end
