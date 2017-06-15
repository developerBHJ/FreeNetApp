//
//  BHJCalendarView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJCalendarModel.h"

@interface BHJCalendarView : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);
@property (nonatomic,strong)  NSMutableArray *signArray;

//今天
@property (nonatomic,strong)  UIButton *dayButton;

- (void)setStyle_Today_Signed:(UIButton *)btn;
- (void)setStyle_Today:(UIButton *)btn;

@end
