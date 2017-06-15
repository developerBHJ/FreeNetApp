//
//  indianaDetailWinningView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndianaDetailModel.h"
@interface indianaDetailWinningView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *user_level;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UIImageView *user_head;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfrome;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *theme;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


+(indianaDetailWinningView *)shareIndianaDetailWinningView;

@property (nonatomic,strong)IndianaDetailModel *model;





@end
