//
//  indianaCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/25.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "indianaCell.h"

@implementation indianaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pre_price.lineType = LineTypeMiddle;
    self.buyBtn.hidden = NO;
    self.tryBtn.hidden = YES;
    // Initialization code
}

- (IBAction)tryAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

- (IBAction)buyAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

-(void)setModel:(IndianaModel *)model{

    _model = model;
    self.goods_name.text = model.name;
    [self.goods_image sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.priceLabel.text = model.purchase_price;
    self.discuntPrice.text = model.snatch_price;
}
@end