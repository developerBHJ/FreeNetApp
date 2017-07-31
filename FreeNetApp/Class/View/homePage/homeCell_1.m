//
//  homeCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/24.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "homeCell_1.h"

@implementation homeCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.time_h1.borderColor = [UIColor colorWithHexString:@"#bebebe"];
    self.time_h1.borderWidth = 1.0;
    
    self.time_h2.borderColor = [UIColor colorWithHexString:@"#bebebe"];
    self.time_h2.borderWidth = 1.0;
    
    self.time_m1.borderColor = [UIColor colorWithHexString:@"#bebebe"];
    self.time_m1.borderWidth = 1.0;
    
    self.time_m2.borderColor = [UIColor colorWithHexString:@"#bebebe"];
    self.time_m2.borderWidth = 1.0;
    
    
    self.time_s1.borderColor = [UIColor colorWithHexString:@"#bebebe"];
    self.time_s1.borderWidth = 1.0;
    
    self.time_s2.borderColor = [UIColor colorWithHexString:@"#bebebe"];
    self.time_s2.borderWidth = 1.0;
    
    self.striveBtn.backgroundColor = HWColor(249, 76, 79, 1.0);
    
    self.timerNow = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
}

-(void)dealloc{
    
    [self.timerNow invalidate];
    self.timerNow = nil;
}

- (IBAction)strive:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

- (void)timerFunc
{
    NSString *str = [self.model.start_time replace:@"T" withString:@" "];
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
    
    if (dateCom.hour > 0) {
        self.time_h1.text = [hourStr substringWithRange:NSMakeRange(0, 1)];
        self.time_h2.text = [hourStr substringWithRange:NSMakeRange(1, 1)];
    }else{
        self.time_h1.text = @"0";
        self.time_h2.text = @"0";
    }
    if (dateCom.minute > 0) {
        self.time_m1.text = [minuteStr substringWithRange:NSMakeRange(0, 1)];
        self.time_m2.text = [minuteStr substringWithRange:NSMakeRange(1, 1)];
    }else{
        self.time_m1.text = @"0";
        self.time_m2.text = @"0";
    }
    if (dateCom.second > 0) {
        self.time_s1.text = [secondStr substringWithRange:NSMakeRange(0, 1)];
        self.time_s2.text = [secondStr substringWithRange:NSMakeRange(1, 1)];
    }else{
        self.time_s1.text = @"0";
        self.time_s2.text = @"0";
        
    }
}

-(void)setModel:(HotRecommend *)model{
    
    _model = model;
    self.subTitle.text = model.shop_free[@"title"];
    self.priceLabel.text = model.shop_free[@"price"];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.shop_free[@"cover_url"]]];
    self.pepoleNum.text = [NSString stringWithFormat:@"%d人正在抢",model.total];
}


@end
