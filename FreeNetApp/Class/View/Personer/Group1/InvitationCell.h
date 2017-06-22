//
//  InvitationCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InvitationModel.h"

@interface InvitationCell : UITableViewCell

@property (nonatomic,strong)InvitationModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *head_image;   //头像

@property (weak, nonatomic) IBOutlet UILabel *user_name;    //昵称

@property (weak, nonatomic) IBOutlet UILabel *user_address; //地址

@property (weak, nonatomic) IBOutlet UILabel *prizeLabel;   //豆

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;    //时间

@property (weak, nonatomic) IBOutlet UILabel *invitationMark;   //邀请标记
@end


