//
//  answerCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnswerModel;
@interface answerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (strong,nonatomic) UIImageView *myImageView;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic, strong) AnswerModel *model;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;


@end
