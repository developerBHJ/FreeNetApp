//
//  OpenOrderCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/22.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OpenOrderCell.h"

@implementation OpenOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:)]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}


-(void)setCouponOrder:(CouponOrder *)couponOrder{
    
    _couponOrder = couponOrder;
   // NSDictionary *shop = couponOrder.shop_coupon[@"shop"];
    NSString *str = [couponOrder.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:couponOrder.shop_coupon[@"cover"]]];
    self.descLabel.text = couponOrder.shop_coupon[@"title"];
    self.subTitle.text = [NSString stringWithFormat:@"下单时间:%@",timeStr];
    self.currentPrice.text = [NSString stringWithFormat:@"%@元",couponOrder.shop_coupon[@"price"]];
    NSInteger status = [couponOrder.status integerValue];
    switch (status) {
        case 0:
            self.bottomBtn.enabled = YES;
            [self.bottomBtn setTitle:@"去支付" forState:UIControlStateNormal];
            break;
        case 1:
            [self.bottomBtn setTitle:@"去使用" forState:UIControlStateNormal];
            self.bottomBtn.enabled = YES;
            break;
        case 2:
            [self.bottomBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
            self.bottomBtn.enabled = YES;
            break;
        case 3:
            [self.bottomBtn setTitle:@"已完成" forState:UIControlStateNormal];
            self.bottomBtn.enabled = NO;
            break;
            
        default:
            break;
    }
}

-(void)setIndianaOrder:(IndianaOrder *)indianaOrder{
    
    NSDictionary *treasure = indianaOrder.user_treasure[@"treasure_plan"][@"treasure"];
    NSString *str = [indianaOrder.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:treasure[@"cover_url"]]];
    
    self.descLabel.text = treasure[@"title"];
    self.subTitle.text = [NSString stringWithFormat:@"下单时间:%@",timeStr];
    self.currentPrice.text = [NSString stringWithFormat:@"%@元",treasure[@"price"]];
    
    NSInteger status = [indianaOrder.status integerValue];
    switch (status) {
        case 0:
            self.bottomBtn.enabled = YES;
            [self.bottomBtn setTitle:@"去支付" forState:UIControlStateNormal];
            break;
        case 1:
            [self.bottomBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            self.bottomBtn.enabled = YES;
            break;
        case 3:
            [self.bottomBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
            self.bottomBtn.enabled = YES;
            break;
        case 4:
            [self.bottomBtn setTitle:@"已完成" forState:UIControlStateNormal];
            self.bottomBtn.enabled = NO;
            break;
            
        default:
            break;
    }

}


-(void)setSpecialOrder:(SpecialOrder *)specialOrder{
    
    _specialOrder = specialOrder;
    NSString *str = [specialOrder.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:specialOrder.shop_product[@"cover_url"]]];
    self.descLabel.text = specialOrder.shop_product[@"title"];
    self.subTitle.text = [NSString stringWithFormat:@"下单时间:%@",timeStr];
    
    self.currentPrice.text = [NSString stringWithFormat:@"%@元",specialOrder.shop_product[@"price"]];
    NSInteger status = [specialOrder.status integerValue];
    switch (status) {
        case 0:
            self.bottomBtn.enabled = YES;
            [self.bottomBtn setTitle:@"去支付" forState:UIControlStateNormal];
            break;
        case 1:
            [self.bottomBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            self.bottomBtn.enabled = YES;
            break;
        case 2:
            [self.bottomBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
            self.bottomBtn.enabled = YES;
            break;
        case 3:
            [self.bottomBtn setTitle:@"已完成" forState:UIControlStateNormal];
            self.bottomBtn.enabled = NO;
            break;
            
        default:
            break;
    }
}
@end
