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
    self.hourLabel.text = [hourMinuteSecond substringWithRange:NSMakeRange(0, 2)];
    self.minuteLabel.text = [hourMinuteSecond substringWithRange:NSMakeRange(3, 2)];
    self.secondLabel.text = [hourMinuteSecond substringWithRange:NSMakeRange(6, 2)];
}

@end
