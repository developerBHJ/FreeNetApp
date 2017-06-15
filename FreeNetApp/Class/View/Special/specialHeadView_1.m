//
//  specialHeadView_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/20.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "specialHeadView_1.h"

@implementation specialHeadView_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)rightAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}






@end
