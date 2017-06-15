//
//  BHJCalendarModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHJCalendarModel : NSObject

+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;
+ (NSInteger)weekDay:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;

@end
