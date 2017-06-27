//
//  homeCell_2.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/24.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "homeCell_2.h"

@implementation homeCell_2

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

- (IBAction)striveAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
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

-(void)setModel:(HotRecommend *)model{
    
    _model = model;
  //  self.subTitle.text = model.name;
  //  self.price.text = model.sell_price;
  //  [self.goods_image sd_setImageWithURL:[NSURL URLWithString:model.img]];
}
@end
