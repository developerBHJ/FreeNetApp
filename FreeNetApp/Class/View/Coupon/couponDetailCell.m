//
//  couponDetailCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "couponDetailCell.h"

@implementation couponDetailCell

-(UIView *)markView{

    if (!_markView) {
        _markView = [[UIView alloc]init];
        _markView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_markView];
    }
    return _markView;
}


- (void)awakeFromNib {
    [super awakeFromNib];

    
}

-(void)setModel:(CashCouponModel *)model{

    _model = model;
    self.titleLabel.text = model.title;
    self.discountLabel.text = [NSString stringWithFormat:@"%@折",model.discount];
    self.discountPrice.text = model.price;
    self.prePrice.text = model.price;
    /*
    CGFloat btnWitdth = self.width / 3;
    if (model.markData.count > 0) {
        self.markView.hidden = NO;
        self.markView.frame = _model.contentImageFrame;
        for (int i = 0; i < self.model.markData.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(btnWitdth * i, 0, btnWitdth, self.markView.height);
            [btn setTitle:self.model.markData[i] forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageNamed:@"close_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
            [btn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:5];
            [self.markView addSubview:btn];
        }
    }else{
        self.markView.hidden = YES;
    }
     */
}



- (IBAction)exchangeAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

@end
