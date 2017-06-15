//
//  indianaDetailHeaderView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/22.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRangeSlider.h"
#import "IndianaDetailModel.h"
@interface indianaDetailHeaderView : UIView<TTRangeSliderDelegate>
@property (weak, nonatomic) IBOutlet UIView *slider;
@property (strong, nonatomic)TTRangeSlider *sliderView;
@property (weak, nonatomic) IBOutlet arrowView *markView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UIImageView *user_head;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfrome;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *user_level;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *indianaPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;

@property (nonatomic,strong)IndianaDetailModel *model;
+(indianaDetailHeaderView *)shareIndianaDetailHeaderView;


@end
