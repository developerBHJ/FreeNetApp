//
//  indianaDetailCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "indianaDetailCell_1.h"

@implementation indianaDetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.prePrice.lineType = LineTypeMiddle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
