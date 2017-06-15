//
//  UserLevelHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/28.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLevelHeadView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *user_image;//头像
@property (weak, nonatomic) IBOutlet UILabel *user_name;//昵称
@property (weak, nonatomic) IBOutlet UIButton *progressBtn;//加速按钮
@property (weak, nonatomic) IBOutlet UIProgressView *progress;//进度条
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;//下一级等级
@property (weak, nonatomic) IBOutlet UILabel *currentLevel;//当前等级
@property (weak, nonatomic) IBOutlet UIImageView *markView;//显示经验值的视图
@property (weak, nonatomic) IBOutlet UILabel *number;//经验数值

@property (weak, nonatomic) IBOutlet UIImageView *levelImage;//等级图片



@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *markViewLeadingX;

+(UserLevelHeadView *)shareCouponHeadView;

@end
