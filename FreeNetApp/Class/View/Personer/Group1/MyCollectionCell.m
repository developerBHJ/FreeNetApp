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

-(void)setModel:(AttentionModel *)model{
    
    [self.storeLogoImage sd_setImageWithURL:[NSURL URLWithString:model.shop[@"logo_url"]]];
    
    self.storeName.text = model.shop[@"title"];
    
    self.detailLabel.text = [NSString stringWithFormat:@"(%@)",model.shop[@"introduction"]];
    
    self.addressLabel.text = model.shop[@"address"];

    self.iphoneNum = model.shop[@"tel"];
}



@end
