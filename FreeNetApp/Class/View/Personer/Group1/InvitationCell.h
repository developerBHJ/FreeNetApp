//
//  InvitationCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *head_image;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_address;
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *invitationMark;



@end


