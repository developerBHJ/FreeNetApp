//
//  MoreCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MoreCell.h"

@implementation MoreCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.rightImage imageFillImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithModel:(PersonerGroup *)model{

    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
}


@end
