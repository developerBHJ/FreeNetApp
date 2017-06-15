//
//  topFunCouponView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topFunCouponView : BHJCustomView

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *store_logo;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *webChartBtn;
@property (weak, nonatomic) IBOutlet UIButton *webCicrleBtn;
@property (weak, nonatomic) IBOutlet UIButton *tencentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topFun_coupon;
@property (weak, nonatomic) IBOutlet UILabel *store_name;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *coupon_price;
@property (weak, nonatomic) IBOutlet UIButton *getBtn;


+(topFunCouponView *)shareTopFunCouponView;

@end
