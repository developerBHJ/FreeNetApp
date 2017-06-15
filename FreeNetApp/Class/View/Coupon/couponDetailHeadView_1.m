//
//  couponDetailHeadView_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/23.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "couponDetailHeadView_1.h"

@implementation couponDetailHeadView_1

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.firstBtn setImage:[[UIImage imageNamed:@"coupon_drop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.firstBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleRight imageTitleSpace:5];
}


- (IBAction)moreAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}

- (IBAction)recommend:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}

- (IBAction)validity:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}


- (IBAction)enternment:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}

- (IBAction)other:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}




@end
