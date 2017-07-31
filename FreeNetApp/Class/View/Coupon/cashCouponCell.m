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
    NSString *str = [model.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    self.validityLabel.text = model.created_at.length > 0 ?
    [@"有效期至：" stringByAppendingString:timeStr] : @"";
    
    self.address.text = model.shop[@"title"];
    self.distance.text = [NSString stringWithFormat:@"%@m",model.invater];
    self.titleLabel.text = model.title;
    self.currentPrice.text = model.discount;
    self.pre_Price.text = model.price;
    self.saleNum.text = [NSString stringWithFormat:@"已售 %@",model.selltotal];
    [self.goods_image sd_setImageWithURL:[NSURL URLWithString:model.cover]];
}


-(void)setOtherModel:(OtherCouponModel *)otherModel{
    
    _otherModel = otherModel;
    self.address.text = otherModel.title;
    NSDictionary *dic = otherModel.shop_coupons[0];
    self.distance.text = [NSString stringWithFormat:@"%@m",otherModel.invater];
    self.titleLabel.text = dic[@"title"];
    CGFloat price = [dic[@"price"] floatValue];
    CGFloat discount = [dic[@"discount"] floatValue];
    self.currentPrice.text = [NSString stringWithFormat:@"%.2f",price * (discount/10)];
    self.pre_Price.text = dic[@"price"];
    [self.goods_image sd_setImageWithURL:[NSURL URLWithString:dic[@"cover"]]];
    
    NSString *str = [dic[@"over_time"] replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    self.validityLabel.text = [dic[@"over_time"] length] > 0 ?
    [@"有效期至：" stringByAppendingString:timeStr] : @"";
}

@end
