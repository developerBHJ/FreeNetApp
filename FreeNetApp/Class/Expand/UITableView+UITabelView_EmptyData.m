//
//  UITableView+UITabelView_EmptyData.m
//  BHJSliderDemo
//
//  Created by xalo on 16/4/22.
//  Copyright © 2016年 baihuajun. All rights reserved.
//

#import "UITableView+UITabelView_EmptyData.h"

@implementation UITableView (UITabelView_EmptyData)

-(NSInteger)showMessage:(NSString *)title byDataSourceCount:(NSInteger)count{
    
    if (count == 0) {
        self.backgroundView=({
            UILabel *label=[[UILabel alloc]init];
            label.text=title;
            label.textAlignment=NSTextAlignmentCenter;
            label;
        });
         self.separatorStyle=UITableViewCellSeparatorStyleNone;
         return count;
    }else{
        self.backgroundView=nil;
        self.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
         return  count;
    }
 }



@end
