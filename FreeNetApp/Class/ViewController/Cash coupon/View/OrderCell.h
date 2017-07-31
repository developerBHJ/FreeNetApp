//
//  OrderCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/27.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashCouponModel.h"
#import "SpecialDetailModel.h"
@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *pricel;

@property (nonatomic,strong)CashCouponModel *model;
@property (nonatomic,strong)SpecialDetailModel *specialModel;




@end
