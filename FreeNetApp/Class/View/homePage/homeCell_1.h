//
//  homeCell_1.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/24.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRecommend.h"
@interface homeCell_1 : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *time_h1;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *pepoleNum;
@property (weak, nonatomic) IBOutlet UIButton *striveBtn;
@property (weak, nonatomic) IBOutlet UILabel *time_h2;
@property (weak, nonatomic) IBOutlet UILabel *colon_1;
@property (weak, nonatomic) IBOutlet UILabel *time_m1;
@property (weak, nonatomic) IBOutlet UILabel *time_m2;
@property (weak, nonatomic) IBOutlet UILabel *colon_2;
@property (weak, nonatomic) IBOutlet UILabel *time_s1;
@property (weak, nonatomic) IBOutlet UILabel *time_s2;

@property (nonatomic,strong)NSTimer *timerNow;

@property (nonatomic,strong)HotRecommend *model;







@end
