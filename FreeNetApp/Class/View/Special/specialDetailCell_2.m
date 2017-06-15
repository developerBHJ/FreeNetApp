//
//  specialDetailCell_2.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "specialDetailCell_2.h"

@implementation specialDetailCell_2

- (void)awakeFromNib {
    [super awakeFromNib];


}


-(void)setModel:(SpecialModel *)model{

    _model = model;
    self.goods_name.text = model.name;
    [self.goods_image sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.subTitle.text = model.title;
    self.priceLabel.text = model.price;
    self.prePriceLabel.text = model.original_price;
    self.buyNumber.text = [NSString stringWithFormat:@"%d人已购买",model.num];
}



@end
