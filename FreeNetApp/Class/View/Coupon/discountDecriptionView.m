//
//  discountDecriptionView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "discountDecriptionView.h"

@implementation discountDecriptionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


+(discountDecriptionView *)shareDiscountDecriptionView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"discountDecriptionView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}






@end
