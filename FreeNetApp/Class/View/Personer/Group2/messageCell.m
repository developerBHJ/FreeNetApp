//
//  messageCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "messageCell.h"

@implementation messageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    TableViewCellBackgroundView *backView = [[TableViewCellBackgroundView alloc]initWithFrame:CGRectZero];
    [self setBackgroundView:backView];
    self.titleLabel.layer.cornerRadius = 5;
    self.titleLabel.layer.masksToBounds = YES;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setModel:(MessageModel *)model{

    self.contentLabel.text = model.msg;
    
    self.timeLabel.text = model.created_at;
}




@end

