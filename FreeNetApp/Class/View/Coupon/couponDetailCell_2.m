//
//  couponDetailCell_2.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "couponDetailCell_2.h"

@implementation couponDetailCell_2

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[BHJTools sharedTools]setLabelLineSpaceWithLabel:self.address space:2];
}


- (IBAction)location:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}


- (IBAction)call:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}


@end
