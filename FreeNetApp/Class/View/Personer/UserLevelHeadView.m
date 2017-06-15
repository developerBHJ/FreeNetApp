//
//  UserLevelHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/28.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "UserLevelHeadView.h"

@implementation UserLevelHeadView

-(void)awakeFromNib{

    [super awakeFromNib];
    
}


+(UserLevelHeadView *)shareCouponHeadView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"UserLevelHeadView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
