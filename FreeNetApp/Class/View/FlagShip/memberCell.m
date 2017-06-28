//
//  memberCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/28.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "memberCell.h"

@implementation memberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)rightAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}


-(void)setModel:(MemeberModel *)model{

    _model = model;
    [self.memberView sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    self.title.text = model.title;
    self.discount.text = model.discount;
    self.number.text = [NSString stringWithFormat:@"%@人领过",model.sellall];
}


@end
