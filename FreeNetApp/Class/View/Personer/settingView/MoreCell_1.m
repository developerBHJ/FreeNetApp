//
//  MoreCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MoreCell_1.h"

@implementation MoreCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)siwtchAction:(UISwitch *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BaseCellMethodWithSwitch:index:)]) {
        [self.delegate BaseCellMethodWithSwitch:sender index:self.index];
    }
}





@end
