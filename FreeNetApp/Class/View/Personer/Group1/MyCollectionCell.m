//
//  MyCollectionCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)call:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:)]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}




@end
