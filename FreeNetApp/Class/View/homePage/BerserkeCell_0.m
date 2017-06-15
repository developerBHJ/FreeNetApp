//
//  BerserkeCell_0.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/8.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkeCell_0.h"

@implementation BerserkeCell_0

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)nextView:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
