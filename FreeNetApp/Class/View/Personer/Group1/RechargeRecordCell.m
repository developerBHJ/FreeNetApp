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

    self.titleLabel.text = @"兑换欢乐豆";
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.coin];
    self.payment.text = [NSString stringWithFormat:@"￥%@",model.gold];
    self.timeLabel.text = model.created_at;
}

@end



