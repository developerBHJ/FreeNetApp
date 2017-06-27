//
//  addressCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "addressCell_1.h"

@implementation addressCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    

    // Initialization code
}


-(void)setModel:(AddressModel *)model{

    self.nameLabel.text = model.truename;
    self.phoneLabel.text = model.mobile;
    self.addressLabel.text = model.address;
}



- (IBAction)editAddress:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

- (IBAction)setDefaultAddress:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

- (IBAction)deleteAddress:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}



@end
