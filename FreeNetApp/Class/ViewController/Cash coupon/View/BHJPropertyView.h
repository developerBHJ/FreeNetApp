//
//  BHJPropertyView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/27.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashCouponModel.h"
#import "SpecialDetailModel.h"
@interface BHJPropertyView : UIView

@property (nonatomic,strong)UITableView *paymentView;

-(void)showPropertyView;
@property (nonatomic,strong)CashCouponModel *model;
@property (nonatomic,strong)SpecialDetailModel *specialModel;

@end
