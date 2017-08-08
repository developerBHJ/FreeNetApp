//
//  RechargeRecordCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RechargeRecordCell.h"
@implementation RechargeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    TableViewCellBackgroundView *backgroundView = [[TableViewCellBackgroundView alloc] initWithFrame:CGRectZero];
    [self setBackgroundView:backgroundView];
    self.payment.layer.cornerRadius = 5;
    self.payment.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



-(void)setModel:(ExchangeRecordModel *)model{
    
    _model = model;
    NSString *str = [model.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    
    self.titleLabel.text = @"兑换欢乐豆";
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.coin];
    self.payment.text = [NSString stringWithFormat:@"￥%@",model.gold];
    self.timeLabel.text = timeStr;
}

-(void)setRechargeM:(RechargeRecordModel *)rechargeM{
    
    _rechargeM = rechargeM;
    NSString *str = [rechargeM.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    
    self.titleLabel.text = @"账户充值";
    self.numberLabel.text = [NSString stringWithFormat:@"¥%@",rechargeM.total];
    if ([rechargeM.type integerValue] == 0) {
        self.payment.text = @"支付宝支付";
    }else if ([rechargeM.type integerValue] == 1){
        self.payment.text = @"微信支付";
    }else{
        self.payment.text = @"银联支付";
    }
    self.timeLabel.text = timeStr;
}

@end



