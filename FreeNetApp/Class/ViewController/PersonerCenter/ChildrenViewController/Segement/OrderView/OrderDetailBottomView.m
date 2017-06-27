//
//  OrderDetailBottomView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OrderDetailBottomView.h"

@implementation OrderDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.viewStyle = isTwo;
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    if (self.viewStyle == isTwo) {
        self.leftBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:@"查看物流" image:nil selector:@selector(BottomButtonEvent:) Frame:CGRectMake(0, 0, self.width / 2, self.height) viewController:nil selectedImage:nil tag:1000];
        self.leftBtn.backgroundColor = [UIColor colorWithHexString:@"#e0c050"];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:self.leftBtn];
        self.rightBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:@"确认收货" image:nil selector:@selector(BottomButtonEvent:) Frame:CGRectMake(self.width / 2, 0, self.width / 2, self.height) viewController:nil selectedImage:nil tag:1001];
        self.rightBtn.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:self.rightBtn];
    }else{
        [self.leftBtn removeFromSuperview];
        self.rightBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:@"已完成" image:nil selector:@selector(BottomButtonEvent:) Frame:CGRectMake(self.width, 0, self.width, self.height) viewController:nil selectedImage:nil tag:1001];
        self.rightBtn.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:self.rightBtn];
    }
}

-(void)BottomButtonEvent:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJCustomViewMethodWithButton:)]) {
        [self.delegate BHJCustomViewMethodWithButton:sender];
    }
}


@end
