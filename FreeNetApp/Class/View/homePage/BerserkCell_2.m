//
//  BerserkCell_2.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/8.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkCell_2.h"

@implementation BerserkCell_2

- (void)awakeFromNib {
    [super awakeFromNib];

    self.timerNow = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)timerFunc
{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSString *hourMinuteSecond = [dateFormatter stringFromDate:date];
    self.time_h1.text = [hourMinuteSecond substringWithRange:NSMakeRange(0, 1)];
    self.time_h2.text = [hourMinuteSecond substringWithRange:NSMakeRange(1, 1)];
    self.time_m1.text = [hourMinuteSecond substringWithRange:NSMakeRange(3, 1)];
    self.time_m2.text = [hourMinuteSecond substringWithRange:NSMakeRange(4, 1)];
    self.time_s1.text = [hourMinuteSecond substringWithRange:NSMakeRange(6, 1)];
    self.time_s2.text = [hourMinuteSecond substringWithRange:NSMakeRange(7, 1)];
}


@end
