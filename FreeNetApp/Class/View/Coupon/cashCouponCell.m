//
//  cashCouponCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "cashCouponCell.h"

@implementation cashCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.pre_Price.lineType = LineTypeMiddle;
}

-(void)setModel:(CashCouponModel *)model{

    _model = model;
    self.address.text = model.shop[@"title"];
    self.distance.text = [NSString stringWithFormat:@"%@m",model.invater];
    self.titleLabel.text = model.title;
    self.currentPrice.text = model.discount;
    self.pre_Price.text = model.price;
    self.saleNum.text = [NSString stringWithFormat:@"已售 %@",model.selltotal];
}


@end
