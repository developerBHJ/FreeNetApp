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
    
    
}



-(void)setModel:(InvitationModel *)model{

    [self.head_image sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];

    self.user_name.text = model.nickname;
    
    self.user_address.text = [NSString stringWithFormat:@"来自:%@",model.region[@"title"]];
    
    self.prizeLabel.text = [NSString stringWithFormat:@"%@",model.coin];
    
    self.timeLabel.text = [model.created_at substringToIndex:10];
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end



