//
//  CreateChatTanleView.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/12/15.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol creatChatTableViewDegelete <NSObject>
- (void)chatTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)textfieldEnd:(UITextField *)textField;
@end
@interface CreateChatTanleView : UITableView
@property (nonatomic, weak)id <creatChatTableViewDegelete>tableViewDegelete;
@property (nonatomic, strong) NSMutableDictionary *dataDic;//数据源
@end
