//
//  UITableView+UITabelView_EmptyData.h
//  BHJSliderDemo
//
//  Created by xalo on 16/4/22.
//  Copyright © 2016年 baihuajun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (UITabelView_EmptyData)

// 根据数据源的个数来判断tableView的显示内容
-(NSInteger)showMessage:(NSString *)title byDataSourceCount:(NSInteger)count;




@end
