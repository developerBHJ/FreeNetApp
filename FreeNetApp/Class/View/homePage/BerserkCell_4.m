//
//  BerserkCell_4.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/8.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkCell_4.h"

@implementation BerserkCell_4

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.backgroundColor = HWColor(239, 239, 239, 1.0);
    [self.awardBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleRight imageTitleSpace:50];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)fabulousAction:(UIButton *)sender {
    
    int count = [self.fabulous.text intValue];
    count +=1;
    NSString *title = [NSString stringWithFormat:@"%d",count];
    self.fabulous.text = title;
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

- (IBAction)lottery:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

- (IBAction)replyAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}






@end
