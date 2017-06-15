//
//  specialFlagCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/12.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "specialFlagCell.h"

@implementation specialFlagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)enterFlagship:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}




@end
