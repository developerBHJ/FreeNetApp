//
//  FlagsMemeberCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/29.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashCouponModel.h"
@interface FlagsMemeberCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (nonatomic,strong)CashCouponModel *model;


@end
