//
//  answerHeadView_2.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "answerHeadView_2.h"

@implementation answerHeadView_2

+(answerHeadView_2 *)shareAnswerHeadView_2{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"answerHeadView_2" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
