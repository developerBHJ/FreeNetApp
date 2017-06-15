//
//  winningCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/27.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "winningCell.h"

@implementation winningCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [[BHJTools sharedTools]setLabelLineSpaceWithLabel:self.content space:2];
    
}

@end
