//
//  moreClassHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "moreClassHeadView.h"

@implementation moreClassHeadView

- (void)awakeFromNib {
    [super awakeFromNib];

    self.themeImage.cornerRadius = 10;
}


-(void)setModel:(ClassModel *)model{

    _model = model;
    [self.themeImage sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    self.titleLabel.text = model.title;
}

@end
