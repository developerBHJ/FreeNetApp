//
//  BHJCalendarView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJCalendarView.h"
#import "BHJCalendarModel.h"

@implementation BHJCalendarView
{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:35];
        for (int i = 0; i < 35; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self addSubview:button];
            self.backgroundColor = [UIColor whiteColor];
            [_daysArray addObject:button];
        }
    }
    return self;
}

#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    
    [self createCalendarViewWith:date];
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.height / 6.26;
    
    // 1.year month
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width - 25, itemH)];
    headView.backgroundColor = HWColor(222, 222, 222, 1.0);
    
    UILabel *headlabel = [[UILabel alloc] init];
    headlabel.text     = [NSString stringWithFormat:@"%li年%li月",(long)[BHJCalendarModel year:date],[BHJCalendarModel month:date]];
    headlabel.font     = [UIFont fontWithName:@"HiraKakuProN-W3" size:15];
    headlabel.frame           = CGRectMake(15, 0, (CGRectGetWidth(headView.frame) - 30)/ 2, itemH);
    headlabel.textAlignment   = NSTextAlignmentLeft;

    UILabel *weakLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(headView.frame) - 30)/ 2 + 15, 0, (CGRectGetWidth(headView.frame) - 30) / 2, itemH)];

    weakLabel.font     = [UIFont systemFontOfSize:15];
    weakLabel.textAlignment   = NSTextAlignmentRight;
    [headView addSubview:headlabel];
    [headView addSubview:weakLabel];
    [self addSubview:headView];
    
    // 2.weekday
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    weakLabel.text = [NSString stringWithFormat:@"%li月%li日 星期%@",(long)[BHJCalendarModel month:date],[BHJCalendarModel day:date],array[[BHJCalendarModel weekDay:date] - 1]];
    weakLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    
    UIView *weekBg = [[UIView alloc] init];
    weekBg.backgroundColor = [UIColor whiteColor];
    weekBg.frame = CGRectMake(10, CGRectGetMaxY(headView.frame), MainScreen_width - 40, itemH * 0.7);
    [self addSubview:weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:15];
        week.frame    = CGRectMake(itemW * i, 0, itemW * 0.5, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        [weekBg addSubview:week];
    }
    
    //  3.days (1-31)
    for (int i = 0; i < 35; i++) {
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x + 10, y, itemW * 0.6, itemW * 0.6);
        dayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = 5.0f;
        [dayButton setTitleColor:[UIColor colorWithHexString:@"e4504b"] forState:UIControlStateSelected];
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [BHJCalendarModel totaldaysInMonth:[BHJCalendarModel lastMonth:date]];
        NSInteger daysInThisMonth = [BHJCalendarModel totaldaysInMonth:date];
        NSInteger firstWeekday    = [BHJCalendarModel firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
        
        // this month
        if ([BHJCalendarModel month:date] == [BHJCalendarModel month:[NSDate date]]) {
            
            NSInteger todayIndex = [BHJCalendarModel day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                [self setStyle_BeforeToday:dayButton];
                [self setSign:i andBtn:dayButton];
            }else if(i ==  todayIndex){
                [self setStyle_Today:dayButton];
                _dayButton = dayButton;
            }
        }
    }
}


#pragma mark 设置已经签到
- (void)setSign:(int)i andBtn:(UIButton*)dayButton{
    [_signArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int now = i-4+1;
        int now2 = [obj intValue];
        if (now2== now) {
            [self setStyle_SignEd:dayButton];
        }
    }];
}


#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
    _selectButton.selected = NO;
    dayBtn.selected = YES;
    _selectButton = dayBtn;
    
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
}


#pragma mark - date button style
//设置不是本月的日期字体颜色   ---白色  看不到
- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor colorWithHexString:@"#bebebe"] forState:UIControlStateNormal];
}

//这个月 今日之前的日期style
- (void)setStyle_BeforeToday:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


//今日已签到
- (void)setStyle_Today_Signed:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor blueColor]];
}

//今日没签到
- (void)setStyle_Today:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#bebebe"]];
}

//这个月 今天之后的日期style
- (void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

//已经签过的 日期style
- (void)setStyle_SignEd:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"e4504b"]];
    btn.layer.cornerRadius = CGRectGetWidth(btn.frame) / 2;
    btn.layer.masksToBounds = YES;
}



@end
