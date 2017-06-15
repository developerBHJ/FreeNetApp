//
//  BerserkHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/8.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkHeadView.h"

@implementation BerserkHeadView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self.rightBtn.imageView imageFillImageView];
    }
    return self;
}

+(BerserkHeadView *)shareBerserkHeadView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"BerserkHeadView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
