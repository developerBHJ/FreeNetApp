//
//  OpenOrderCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/22.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponOrder.h"
#import "SpecialOrder.h"
#import "IndianaOrder.h"
@interface OpenOrderCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (nonatomic,strong)CouponOrder *couponOrder;
@property (nonatomic,strong)SpecialOrder *specialOrder;
@property (nonatomic,strong)IndianaOrder *indianaOrder;



@end
