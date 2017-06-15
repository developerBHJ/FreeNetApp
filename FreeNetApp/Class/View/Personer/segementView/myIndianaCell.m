//
//  myIndianaCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "myIndianaCell.h"

@implementation myIndianaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.prePrice.lineType = LineTypeMiddle;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(OrderModel *)model{

    [self.goods_image sd_setImageWithURL:[NSURL URLWithString:model.img]];//图片
    
    self.goods_name.text = model.goods_name;    //商品名
    
    self.goods_name.text = model.real_price;    //真实价格
    
    self.subTitle.text = model.goods_price;     //商品价格
    
    self.time.text = model.pay_time;            //时间
}



- (IBAction)behavior:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}



@end
