//
//  specialiDetailCell_7.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "specialiDetailCell_7.h"

@implementation specialiDetailCell_7

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.firstBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleRight imageTitleSpace:5];
}

- (IBAction)recommend:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}


- (IBAction)delicacy:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}


- (IBAction)entertainment:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}


- (IBAction)other:(UIButton *)sender {
  
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

@end
