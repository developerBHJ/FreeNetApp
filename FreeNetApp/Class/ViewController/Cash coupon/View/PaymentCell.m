//
//  PaymentCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/2.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "PaymentCell.h"

@implementation PaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.right_icon.image = [[UIImage imageNamed:@"selected_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        self.right_icon.image = [[UIImage imageNamed:@"nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

@end
