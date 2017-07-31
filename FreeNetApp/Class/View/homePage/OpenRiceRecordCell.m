//
//  OpenRiceRecordCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "OpenRiceRecordCell.h"

@implementation OpenRiceRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.userName setFont:[UIFont systemFontOfSize:12]];
    self.userName.textColor = [UIColor colorWithHexString:@"#000000"];
    [self.comefrom setFont:[UIFont systemFontOfSize:12]];
    self.comefrom.textColor = [UIColor colorWithHexString:@"#bebebe"];
    self.address.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.address setFont:[UIFont systemFontOfSize:12]];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setModel:(OpenHistoryModel *)model{
    
    _model = model;
    self.userName.text = model.user[@"nickname"];
    [self.user_image sd_setImageWithURL:[NSURL URLWithString:model.user[@"avatar_url"]]];
    [self.levelMark sd_setImageWithURL:[NSURL URLWithString:model.user[@"user_level"][@"level"][@"cover_url"]]];
    self.address.text = model.user[@"region"][@"title"];
    
    [self.goods_image sd_setImageWithURL:[NSURL URLWithString:model.shop_food_plan[@"shop_food"][@"cover_url"]]];
    self.contentLabel.text = [NSString stringWithFormat:@"%@ x",model.shop_food_plan[@"shop_food"][@"shop"][@"title"]];
    // self.goodsNum.text = @"";
    self.subContent.text = model.shop_food_plan[@"shop_food"][@"title"];
    
}

@end
