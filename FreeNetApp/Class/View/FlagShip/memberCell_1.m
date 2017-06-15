//
//  memberCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/28.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "memberCell_1.h"

@implementation memberCell_1

- (void)awakeFromNib {
    [super awakeFromNib];

    [[BHJTools sharedTools]setLabelLineSpaceWithLabel:self.content space:2];

}

@end
