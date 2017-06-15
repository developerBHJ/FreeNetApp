//
//  InvitationCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "InvitationCell.h"

@implementation InvitationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    TableViewCellBackgroundView *backgroundView = [[TableViewCellBackgroundView alloc] initWithFrame:CGRectZero];
    
    [self setBackgroundView:backgroundView];
    
    self.invitationMark.layer.cornerRadius = 3;
    self.invitationMark.layer.masksToBounds = YES;
    
    NSString *content = @"100欢乐豆";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:content];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#e4504b"] range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#696969"] range:NSMakeRange(3, 3)];

    self.prizeLabel.attributedText = attributedStr;
    
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end



