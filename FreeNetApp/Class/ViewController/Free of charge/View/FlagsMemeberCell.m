//
//  FlagsMemeberCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/29.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "FlagsMemeberCell.h"

@implementation FlagsMemeberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(CashCouponModel *)model{
    
    _model = model;
   // [self.storeIcon sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.end_time;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",model.price];
    self.number.text = [NSString stringWithFormat:@"%@人领取",model.selltotal];
}




@end
