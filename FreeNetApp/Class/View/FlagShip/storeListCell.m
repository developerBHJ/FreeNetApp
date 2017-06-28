//
//  storeListCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/27.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "storeListCell.h"

@implementation storeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)call:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}


-(void)setStoreModel:(FlagStoreModel *)storeModel{

    _storeModel = storeModel;
    self.store_name.text = storeModel.title;
    self.addressLabel.text = storeModel.address;
    
}


@end
