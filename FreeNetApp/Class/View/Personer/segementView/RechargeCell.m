//
//  RechargeCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RechargeCell.h"

@implementation RechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

-(void)setCellWithModel:(PersonerGroup *)model{
    
    self.payment.image = [[UIImage imageNamed:model.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    if (model.isSelected) {
        self.selectedImage.image = [[UIImage imageNamed:@"selected_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        self.selectedImage.image = [UIImage imageNamed:@"nomal"];
    }
}


@end
