//
//  RecommendCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pre_priceLabel.lineType = LineTypeMiddle;
    
    // Initialization code
}


-(void)setModel:(SpecialModel *)model{

    _model = model;
    self.good_name.text = model.name;
    [self.good_image sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.couponLabel.text = model.title;
    self.priceLabel.text = model.price;
    self.pre_priceLabel.text = model.original_price;
    self.markLabel.text = [NSString stringWithFormat:@"已售 %d",model.num];
}
@end
