//
//  PropertyHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/2.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "PropertyHeadView.h"

@implementation PropertyHeadView

+(PropertyHeadView *)sharePropertyHeadView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"PropertyHeadView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
@end
