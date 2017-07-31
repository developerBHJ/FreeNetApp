//
//  couponClassCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "couponClassCell.h"

@implementation couponClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rightBtn.hidden = YES;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];



}


-(void)setModel:(BHJDropModel *)model{

    _model = model;
    self.titleLabel.text = model.name;
  //  [self.rightBtn setTitle:model.subTitle forState:UIControlStateNormal];
    //计算大小
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    CGSize buttonSize = [model.subTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.buttonWidth.constant = buttonSize.width + 10;
    self.rightBtn.cornerRadius = self.rightBtn.height / 2.5;
    //给imageView赋值
    [self.leftView sd_setImageWithURL:[NSURL URLWithString:model.headImage]];
}



@end
