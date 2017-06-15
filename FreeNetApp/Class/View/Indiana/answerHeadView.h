//
//  answerHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface answerHeadView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *user_headView;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIImageView *user_level;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIView *timerView;


+(answerHeadView *)shareanswerHeadView;




@end
