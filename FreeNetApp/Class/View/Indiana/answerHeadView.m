//
//  answerHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "answerHeadView.h"

@implementation answerHeadView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {

        
    }
    return self;
}


+(answerHeadView *)shareanswerHeadView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"answerHeadView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
