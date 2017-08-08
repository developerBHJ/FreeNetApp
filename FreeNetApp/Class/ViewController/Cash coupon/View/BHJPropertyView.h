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
#import "IndianaDetailModel.h"
typedef NS_ENUM(NSInteger,BHJPropertyViewType) {

    BHJPropertyViewTypeWithCoin,
    BHJPropertyViewTypeWithCash
};

@interface BHJPropertyView : UIView

@property (nonatomic,strong)UITableView *paymentView;

-(instancetype)initWithFrame:(CGRect)frame payment:(BHJPropertyViewType)payment;
-(void)showPropertyView;
@property (nonatomic,strong)CashCouponModel *model;
@property (nonatomic,strong)SpecialDetailModel *specialModel;
@property (nonatomic,strong)IndianaDetailModel *indianaModel;

@property (nonatomic,assign)BHJPropertyViewType payType;

@end
