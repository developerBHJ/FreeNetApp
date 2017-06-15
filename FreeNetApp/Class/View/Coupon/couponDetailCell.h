//
//  couponDetailCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "couponModel.h"

@interface couponDetailCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountPrice;
@property (weak, nonatomic) IBOutlet UILabel *prePrice;
@property (weak, nonatomic) IBOutlet UILabel *timeAleterLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIButton *exChangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@property (nonatomic,strong)couponModel *model;
@property (nonatomic,strong)UIView *markView;

@end
