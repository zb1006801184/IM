//
//  GJEmotionModel.h
//  GJKeyboard
//
//  Created by Jerry_hqyj on 2017/11/22.
//  Copyright © 2017年 socket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJEmotionModel : NSObject

- (instancetype)initWithDic:(NSDictionary*)dic;

@property (nonatomic, copy)   NSString *themeIcon;
@property (nonatomic, copy)   NSString *themeDecribe;
@property (nonatomic, strong) NSArray *faceModels;

@end
