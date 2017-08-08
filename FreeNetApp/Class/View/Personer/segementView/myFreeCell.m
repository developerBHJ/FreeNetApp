//
//  myFreeCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "myFreeCell.h"

@implementation myFreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lotteryNum.cornerRadius = self.lotteryNum.width / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(FreeOrderModel *)model{

    _model = model;
    self.subTitle.hidden = YES;
    
    NSString *str = [model.created_at replace:@"T" withString:@" "];
    NSString *timeStr = [str substringToIndex:19];
    
    NSDictionary *dic = model.user_free[@"shop_free_plan"][@"shop_free"];
   [self.goods_image sd_setImageWithURL:[NSURL URLWithString:dic[@"cover_url"]]];//图片
    self.lotteryNum.text = [NSString stringWithFormat:@"%@",model.user_free[@"free_no"]];
    self.goods_name.text = dic[@"title"];    //商品名
    self.priceLabel.text = dic[@"price"];     //商品价格
    self.timeLabel.text = timeStr;   //支付时间
    self.postageLabel.text = [NSString stringWithFormat:@"邮费:%@元",dic[@"fee"]];
    NSInteger status = [model.status integerValue];
    switch (status) {
        case 0:
            self.payBtn.enabled = YES;
            [self.payBtn setTitle:@"去领奖" forState:UIControlStateNormal];
            break;
        case 1:
            [self.payBtn setTitle:@"去使用" forState:UIControlStateNormal];
            self.payBtn.enabled = YES;
            break;
        case 2:
            [self.payBtn setTitle:@"已弃奖" forState:UIControlStateNormal];
            self.payBtn.enabled = NO;
            break;
        case 3:
            [self.payBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            self.payBtn.enabled = YES;
            break;
        case 4:
            [self.payBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
            self.payBtn.enabled = YES;
            break;
        case 5:
            [self.payBtn setTitle:@"已完成" forState:UIControlStateNormal];
            self.payBtn.enabled = NO;
            break;
            
        default:
            break;
    }
}





- (IBAction)payAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

@end
