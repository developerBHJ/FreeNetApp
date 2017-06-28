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
    
}


-(void)setModel:(SpecialModel *)model{

    _model = model;
    self.good_name.text = model.title;
    [self.good_image sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    self.couponLabel.text = model.introduction;
    self.priceLabel.text = model.discount;
    self.pre_priceLabel.text = model.price;
    self.markLabel.text = [NSString stringWithFormat:@"已售 %@",model.sell];
}
@end
