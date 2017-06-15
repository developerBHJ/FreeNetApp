//
//  answerCell_2.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "answerCell_2.h"

@implementation answerCell_2

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.subTitle.textColor = [UIColor whiteColor];
    self.rightLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
