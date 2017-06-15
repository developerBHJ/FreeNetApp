//
//  topFunCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "topFunCell.h"

@implementation topFunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.secondView.hidden = YES;
    self.thirdView.hidden = YES;
    CollectionViewBackgroundView *backgroundView = [[CollectionViewBackgroundView alloc]init];
    self.backgroundView = backgroundView;
}

- (IBAction)buyAction:(UIButton *)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]){
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}



@end
