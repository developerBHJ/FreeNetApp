//
//  topFunBuyView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topFunBuyView : BHJCustomView

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *store_logo;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *alertTitle;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *webChartBtn;
@property (weak, nonatomic) IBOutlet UIButton *webCicrleBtn;
@property (weak, nonatomic) IBOutlet UIButton *tencentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *prePrice;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

+(topFunBuyView *)shareTopFunBuyView;

@end
