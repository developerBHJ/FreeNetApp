//
//  CopounOrderCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/22.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "CopounOrderCell.h"

@implementation CopounOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:)]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

-(void)setModel:(OpenOrder *)model{

    _model = model;
    NSString *str = [model.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    self.timeLabel.text = timeStr;
    NSDictionary *food = model.user_food[@"shop_food_plan"][@"shop_food"];
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:food[@"cover_url"]]];
    self.priceLabel.text = food[@"price"];
    self.titleLabel.text = food[@"title"];
    self.subTitleLabel.hidden = YES;
    
    NSInteger status = [model.status integerValue];
    switch (status) {
        case 0:
            self.useBtn.hidden = NO;
            self.markImage.hidden = YES;
            self.selectedImage.hidden = YES;
            self.backImage.image = [UIImage imageNamed:@"CopunBG_red"];
            break;
        case 1:
            self.useBtn.hidden = YES;
            self.markImage.hidden = NO;
            self.selectedImage.hidden = YES;
            self.backImage.image = [UIImage imageNamed:@"CopunBG_gray"];
            break;
        case 2:
            self.useBtn.hidden = YES;
            self.markImage.hidden = YES;
            self.selectedImage.hidden = NO;
            self.backImage.image = [UIImage imageNamed:@"CopunBG_gray"];
            break;
            
        default:
            break;
    }


}

@end
