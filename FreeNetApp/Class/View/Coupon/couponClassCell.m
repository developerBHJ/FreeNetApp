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

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];



}


-(void)setModel:(BHJDropModel *)model{

    _model = model;
    self.titleLabel.text = model.title;
    [self.rightBtn setTitle:model.subTitle forState:UIControlStateNormal];
    //计算大小
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    CGSize buttonSize = [model.subTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.buttonWidth.constant = buttonSize.width + 10;
    self.rightBtn.cornerRadius = self.rightBtn.height / 2.5;
    //给imageView赋值
    if (model.imageName.length) {
        self.leftView.hidden = NO;
        self.leftView.image = [UIImage imageNamed:model.imageName];
    } else {
        self.leftView.hidden = YES;
    }
}



@end
