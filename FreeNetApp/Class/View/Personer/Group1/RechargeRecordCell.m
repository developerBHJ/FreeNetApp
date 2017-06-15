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



-(void)setModel:(RechargeModel *)model{

    //self.cardNum.text = model.            //银行卡号
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.money];    //充值金额

    self.timeLabel.text = model.pay_time;   //充值时间
    
    switch ([model.pay_type intValue]) {    //支付方式
        case 1:
            self.payment.text = @"支付宝支付";
            self.payment.backgroundColor = [UIColor blueColor];
            break;
        case 2:
            self.payment.text = @"微信支付";
            self.payment.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.payment.text = @"银联支付";
            self.payment.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
}

@end



