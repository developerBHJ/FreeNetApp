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
    self.timeLabel.text = model.created_at.length > 0 ?model.created_at : @"2017-08-01 12:00:00";
    if ([model.type integerValue] == 1) {
        self.titleLabel.text = @"系统消息";
    }else if ([model.type integerValue] == 2){
        self.titleLabel.text = @"物流消息";
    }
    
    if (model.enabled == true) {
        self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.markLabel.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.markLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    }
}




@end

