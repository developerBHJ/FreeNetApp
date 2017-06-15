//
//  IndianaResaurantCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndianaResaurantCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *prePrice;

@property (weak, nonatomic) IBOutlet UILabel *discountPrice;
@property (weak, nonatomic) IBOutlet UIButton *striveBtn;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;

@end
