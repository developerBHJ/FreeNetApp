//
//  shareCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "shareCell.h"

@implementation shareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithModel:(PersonerGroup *)model{

    self.leftView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.title;

}

@end
