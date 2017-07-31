//
//  OrderCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/27.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setModel:(CashCouponModel *)model{
    
    _model = model;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:self.model.cover]];
    self.title.text = self.model.title;
    self.subTitle.text = self.model.shop[@"title"];
    self.pricel.text = self.model.price;
}

-(void)setSpecialModel:(SpecialDetailModel *)specialModel{
    
    _specialModel = specialModel;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:self.specialModel.cover_url]];
    self.title.text = self.specialModel.title;
    self.subTitle.text = self.specialModel.introduction;
    self.pricel.text = self.specialModel.price;
}

@end
