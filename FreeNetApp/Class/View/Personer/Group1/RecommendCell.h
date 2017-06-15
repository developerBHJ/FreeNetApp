//
//  RecommendCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialModel.h"
@interface RecommendCell : BaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *pre_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;

@property (nonatomic,strong)SpecialModel *model;

@end
