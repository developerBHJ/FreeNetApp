//
//  IndianaResaurantCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "IndianaResaurantCell.h"

@implementation IndianaResaurantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.prePrice.lineType = LineTypeMiddle;
    
    
    
}


- (IBAction)strive:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}








@end
