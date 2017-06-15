//
//  EvaluationFooterView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "EvaluationFooterView.h"

@implementation EvaluationFooterView


- (IBAction)pickAndSendPicture:(UIButton *)sender {
    
    if (self.footerViewAction != nil) {
        self.footerViewAction(sender.tag);
    }
}
- (IBAction)submitContent:(UIButton *)sender {
    
    if (self.footerViewAction != nil) {
        self.footerViewAction(sender.tag);
    }
}



+(EvaluationFooterView *)shareEvaluationFooterView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"EvaluationFooterView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
