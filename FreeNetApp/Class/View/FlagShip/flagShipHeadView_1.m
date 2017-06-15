//
//  flagShipHeadView_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "flagShipHeadView_1.h"

@implementation flagShipHeadView_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)moreAction:(UIButton *)sender {
  
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}



@end
