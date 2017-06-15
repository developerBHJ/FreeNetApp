//
//  topFunBuyView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "topFunBuyView.h"

@implementation topFunBuyView

-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {

        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
    }
    return self;
}

+(topFunBuyView *)shareTopFunBuyView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"topFunBuyView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


- (IBAction)buttonAction:(UIButton *)sender {
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJCustomViewMethodWithButton:)]) {
        [self.delegate BHJCustomViewMethodWithButton:sender];
    }
}


- (IBAction)closeAction:(UIButton *)sender {
    
    [self removeFromSuperview];
}





@end
