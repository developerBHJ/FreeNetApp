//
//  EvaluationHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "EvaluationHeadView.h"

@implementation EvaluationHeadView


- (IBAction)clickAction:(UIButton *)sender {
    
    if (self.myTapAction != nil) {
        self.myTapAction(self.section);
    }
}


+(EvaluationHeadView *)shareEvaluationHeadView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"EvaluationHeadView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
@end
