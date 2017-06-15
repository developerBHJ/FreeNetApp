//
//  isLandCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "isLandCell.h"
@implementation isLandCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.preservesSuperviewLayoutMargins = NO;
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    self.rightView.fillColor = [UIColor whiteColor];
    self.rightView.strokeColor = [UIColor whiteColor];
    [self.themeImage imageFillImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#e4504b"]];
        self.themeImage.image = [[UIImage imageNamed:self.model.subTitle]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.rightView.hidden = NO;
        self.rightView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#696969"]];
        self.themeImage.image = [[UIImage imageNamed:self.model.imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.rightView.hidden = YES;
    }
}

-(void)setModel:(PersonerGroup *)model{

    _model = model;
    self.titleLabel.text = model.title;
    self.themeImage.image = [[UIImage imageNamed:model.imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



@end
