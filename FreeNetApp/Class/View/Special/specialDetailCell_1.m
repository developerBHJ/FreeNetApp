//
//  specialDetailCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "specialDetailCell_1.h"

@implementation specialDetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.prePrice.lineType = LineTypeMiddle;
}

- (IBAction)striveAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

-(void)setModel:(SpecialDetailModel *)model{
    
    _model = model;
    self.currentPrice.text = model.discount;
    self.prePrice.text = [NSString stringWithFormat:@"%@元",model.price];
    self.titleLabel.text = model.title;
    if (model.is_appointment) {
        [self.firstBtn setImage:[UIImage imageNamed:@"selected_green"] forState:UIControlStateNormal];
    }else{
        [self.firstBtn setImage:[UIImage imageNamed:@"selected_gray"] forState:UIControlStateNormal];
    }
    if (model.is_return) {
        [self.secondBtn setImage:[UIImage imageNamed:@"selected_green"] forState:UIControlStateNormal];
    }else{
        [self.secondBtn setImage:[UIImage imageNamed:@"selected_gray"] forState:UIControlStateNormal];
    }
    if (model.is_expired_return) {
        [self.thirdBtn setImage:[UIImage imageNamed:@"selected_green"] forState:UIControlStateNormal];
    }else{
        [self.thirdBtn setImage:[UIImage imageNamed:@"selected_gray"] forState:UIControlStateNormal];
    }
}

@end
