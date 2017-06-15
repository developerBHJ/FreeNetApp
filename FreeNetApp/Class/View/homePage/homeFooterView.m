//
//  homeFooterView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/24.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "homeFooterView.h"

@implementation homeFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    self.secondLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.firstLabel setFont:[UIFont systemFontOfSize:12]];
    [self.secondLabel setFont:[UIFont systemFontOfSize:12]];
}


- (IBAction)queryAll:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}

@end
