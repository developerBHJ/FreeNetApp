//
//  answerHeadView_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "answerHeadView_1.h"

@implementation answerHeadView_1

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        self.user_name.textColor = [UIColor whiteColor];
    }
    return self;
}



+(answerHeadView_1 *)shareAnswerHeadView_1{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"answerHeadView_1" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
