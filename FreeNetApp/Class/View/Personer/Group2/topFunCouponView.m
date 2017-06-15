//
//  topFunCouponView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "topFunCouponView.h"

@implementation topFunCouponView


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
    }
    return self;
}


+(topFunCouponView *)shareTopFunCouponView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"topFunCouponView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}



- (IBAction)closeAction:(UIButton *)sender {
    
    [self removeFromSuperview];
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJCustomViewMethodWithButton:)]) {
        [self.delegate BHJCustomViewMethodWithButton:sender];
    }
}








@end
