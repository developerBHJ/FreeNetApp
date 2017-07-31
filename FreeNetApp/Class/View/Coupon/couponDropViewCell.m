//
//  couponDropViewCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/5.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "couponDropViewCell.h"

@implementation couponDropViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BHJDropModel *)model{
    
    _model = model;
    self.titleLabel.text = model.name;
}
@end
