//
//  searchCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/2/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "searchCell.h"

@implementation searchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(SearchModel *)model{

    self.contentLabel.text = model.title;
    
    self.searchId = model.searchId;
}




@end
