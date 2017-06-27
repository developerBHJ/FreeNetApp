//
//  OpenOrderCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/22.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OpenOrderCell.h"

@implementation OpenOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pre_price.lineType = LineTypeMiddle;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
