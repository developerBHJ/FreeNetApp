//
//  BerserkCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/8.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkCell_1.h"

@implementation BerserkCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)dealloc{
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)handleDisplayLink:(CADisplayLink *)sender
{
    NSString *str = nil;
    if (self.status == cellStatusWithLead) {
        str = [self.model.end_time replace:@"T" withString:@" "];
    }else{
        str = [self.model.start_time replace:@"T" withString:@" "];
    }
    NSString *timeStr = [str substringToIndex:19];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];//时间管理
    [formatter setDateStyle:NSDateFormatterMediumStyle];//时间方式
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSDate *nowDate = [NSDate date];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:date options:0];
    
    NSString *hourStr = dateCom.hour >= 10 ? [NSString stringWithFormat:@"%ld",dateCom.hour] : [NSString stringWithFormat:@"0%ld",dateCom.hour];
    NSString *minuteStr = dateCom.minute >= 10 ? [NSString stringWithFormat:@"%ld",dateCom.minute] : [NSString stringWithFormat:@"0%ld",dateCom.minute];
    NSString *secondStr = dateCom.second >= 10 ? [NSString stringWithFormat:@"%ld",dateCom.second] : [NSString stringWithFormat:@"0%ld",dateCom.second];
    
    self.hourLabel.text = dateCom.hour > 0 ? hourStr : @"00";
    self.minuteLabel.text = dateCom.minute > 0 ? minuteStr : @"00";
    self.secondLabel.text = dateCom.second > 0 ? secondStr : @"00";
    
    NSString *endTime = [self.model.end_time replace:@"T" withString:@" "];
    
    NSString *endStr = [endTime substringToIndex:19];
    NSDate *endDate = [formatter dateFromString:endStr];
    
    long d1 = [self getDateTimeTOMilliSeconds:date];
    long d2 = [self getDateTimeTOMilliSeconds:nowDate];
    long d3 = [self getDateTimeTOMilliSeconds:endDate];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (d2 > d1) {
        [dic setValue:@"1" forKey:@"isStart"];
        self.titleLabel.text = @"距离结束:";
        self.hourLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
        self.minuteLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
        self.secondLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    }else{
        [dic setValue:@"0" forKey:@"isStart"];
        self.titleLabel.text = @"即将开始:";
        self.hourLabel.backgroundColor = [UIColor colorWithHexString:@"#62B44D"];
        self.minuteLabel.backgroundColor = [UIColor colorWithHexString:@"#62B44D"];
        self.secondLabel.backgroundColor = [UIColor colorWithHexString:@"#62B44D"];
    }
    if (d2 > d3) {
        [dic setValue:@"1" forKey:@"isEnd"];
    }else{
        [dic setValue:@"0" forKey:@"isEnd"];
    }
    NSNotification *message = [[NSNotification alloc]initWithName:@"TimeString" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:message];
}

//将NSDate类型的时间转换为时间戳,从1970/1/1开始
-(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
    return totalMilliseconds;
}

-(void)setModel:(HotRecommend *)model{
    
    _model = model;
}
@end
