//
//  addressCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "addressCell.h"

@implementation addressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(AddressModel *)model{
    
    self.user_name.text = model.truename;
    self.user_phone.text = model.mobile;
    self.user_address.text = model.address;
}



@end
