//
//  HomeSegmentView.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "HomeSegmentView.h"
#import "HomeSegmentaImageCell.h"
#import "HomeSegmentImagesCell.h"
#import "HomeSegmentVideoCell.h"
#import "HomeSegmenttextCell.h"



@interface HomeSegmentView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation HomeSegmentView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _data = [NSMutableArray array];
        [_data addObject:@"1"];
        [_data addObject:@"2"];
        [_data addObject:@"3"];
        [_data addObject:@"2"];
        [_data addObject:@"4"];
        [_data addObject:@"1"];
        [_data addObject:@"2"];
        [_data addObject:@"3"];
        [_data addObject:@"2"];
        [_data addObject:@"4"];

        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        //    设置分割线颜色
//        [_tableView setSeparatorColor:[UIColor clearColor]];
        [self addSubview:_tableView];
        [self.tableView setTableFooterView:[UIView new]];

        
        [self.tableView registerClass:[HomeSegmenttextCell class] forCellReuseIdentifier:@"HomeSegmenttextCell"];//纯文字的cell
        [self.tableView registerClass:[HomeSegmentaImageCell class] forCellReuseIdentifier:@"HomeSegmentaImageCell"];//一张图片的cell
        [self.tableView registerClass:[HomeSegmentImagesCell class] forCellReuseIdentifier:@"HomeSegmentImagesCell"];//多张图片的cell
        [self.tableView registerClass:[HomeSegmentVideoCell class] forCellReuseIdentifier:@"HomeSegmentVideoCell"];//播放视频的cell

        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 200;
    }
    return self;
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    /**
     *  id类型的cell 通过取出来Model的类型，判断要显示哪一种类型的cell
     */    
    if ([_data[indexPath.row] isEqualToString:@"1"]) {
        
        HomeSegmentaImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSegmentaImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if ([_data[indexPath.row] isEqualToString:@"2"]){
        
        HomeSegmentImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSegmentImagesCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if ([_data[indexPath.row] isEqualToString:@"3"]){
        
        HomeSegmentVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSegmentVideoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([_data[indexPath.row] isEqualToString:@"4"]){
        
        HomeSegmenttextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSegmenttextCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }



    return nil;

}
//#pragma mark - UITableViewCellDelegate
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 200;
//    return self.tableView.rowHeight;
//}

@end
