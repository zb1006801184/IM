//
//  IMNetModel.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/19.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "IMNetModel.h"
#import "BaseModel.h"
#import "GroupModel.h"
@implementation IMNetModel
+ (void)findAllGroupChatWith:(NSString *)userId  success:(void (^)( id  _Nonnull responseObject))success failure:(void (^)(NSError * _Nonnull error))failure{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_FINDALLGROUPCHAT option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0) {
            NSArray *lists = responseObject[@"content"];
            NSMutableArray *dataList = [NSMutableArray array];
            for (NSArray *list in lists) {
                NSMutableArray *groupAry = [NSMutableArray array];
                for (NSDictionary *dic in list) {
                    GroupModel *model = [GroupModel mj_objectWithKeyValues:dic];
                    [groupAry addObject:model];
                    //筛选 （是否被禁言）
                    NSArray *userIds = [model.prohibitUserSpeak componentsSeparatedByString:@","];
                    for (NSString *userid in userIds) {
                        if ([userid isEqualToString:userId]) {
                            model.isProhibit = YES;
                        }
                    }
                }
                [dataList addObject:groupAry];
            }
            success(dataList);
        }
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)dissolveGroupChatWith:(nonnull NSString *)userId  groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_DISSOLVEGROUPCHAT option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}

+ (void)exitGroupChatWithUserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_EXITGROUPHAT option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)addGroupChatWithUserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_JIONGROUCHAT option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)createGroupChatWithUserId:(nonnull NSString *)userId   groupNumberByMax:(nonnull NSString *)groupNumberByMax groupType:(nonnull NSString *)groupType groupName:(nonnull NSString *)groupName descrbe:(nonnull NSString *)descrbe  topic:(nonnull NSString *)topic  imageUrl:(nonnull NSString *)imageUrl  groupUserType:(nonnull NSString *)groupUserType success:(void (^ _Nullable)(id _Nonnull))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupNumberByMax forKey:@"groupNumberByMax"];
    [paramDic setObject:groupType forKey:@"groupType"];
    [paramDic setObject:groupName forKey:@"groupName"];
    [paramDic setObject:descrbe forKey:@"descrbe"];
    [paramDic setObject:topic forKey:@"topic"];
    [paramDic setObject:imageUrl forKey:@"imageUrl"];
    [paramDic setObject:groupUserType forKey:@"groupUserType"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_CREATEGROUPCHAT option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);

    }];
}
+ (void)queryUserListWithUserId:(nonnull NSString *)userId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_QUERYUSERLIST option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)findGroupDetailWithUserId:(nonnull NSString *)userId  groupId:(nonnull NSString *)groupId  uccess:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_FINDROUPDETAIL option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)queryApprovedListWithUserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId  uccess:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_QUREYAPPROVEDLIST option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)kickOutGroupWithgroupId:(nonnull NSString *)groupId  userId:(nonnull NSString *)userId  manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [paramDic setObject:manageId forKey:@"manageId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_KICKOUTGROUP option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)refuseUserJoinWithgroupId:(nonnull NSString *)groupId  userId:(nonnull NSString *)userId  manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [paramDic setObject:manageId forKey:@"manageId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_REFUSEUSERJION option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];}

+ (void)aggreeTpJionWithgroupId:(nonnull NSString *)groupId  userId:(nonnull NSString *)userId  manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [paramDic setObject:manageId forKey:@"manageId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_AGREETOJION option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)filedUploadWithData:(nonnull NSData *)data type:(nonnull NSString *)type success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure{
//    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_FILEUPLOAD option:IPHNetWorkHelperOptionUPLOAD parameters:nil data:data dataKey:@"urlFile" progress:^(NSProgress * _Nullable uploadProgress) {
//
//    } success:^(id  _Nullable responseObject) {
//        success(responseObject);
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
    NSString *url = [YST_API_URLNAMEIMAGE stringByAppendingString:YST_API_FILEUPLOAD];
    [[YSTNetWorkHelper networkHelper]Upload:url params:nil type:type thumb:data key:@"urlFile" progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

+ (void)addGroupChatWithuserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_INVITINGUSERS option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
+ (void)prohibitUserSpeakWithuserIduserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [paramDic setObject:manageId forKey:@"manageId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_PROHIBITUSERSPEAKER option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}

+ (void)removeProhibitUserSpeakWithuserIduserId:(nonnull NSString *)userId groupId:(nonnull NSString *)groupId manageId:(nonnull NSString *)manageId success:(void (^_Nullable)(id _Nonnull responseObject))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:userId forKey:@"userId"];
    [paramDic setObject:groupId forKey:@"groupId"];
    [paramDic setObject:manageId forKey:@"manageId"];
    [[YSTNetWorkHelper networkHelper]callAPI:YST_API_REMOVEPROHIBITUSERSPEAK option:IPHNetWorkHelperOptionPOST parameters:paramDic data:nil dataKey:nil progress:nil success:^(id  _Nullable responseObject) {
        BaseModel *mainModel = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([mainModel.code integerValue] == 0)  {
            
        }
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
