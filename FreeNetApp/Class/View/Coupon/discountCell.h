//
//  discountCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "discountModel.h"

@interface discountCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *prePrice;
@property (weak, nonatomic) IBOutlet UIImageView *location_icon;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *user_headImage;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *user_level;
@property (weak, nonatomic) IBOutlet UIButton *vertifyBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *commitNum;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;


@property (nonatomic,strong)PYPhotosView *photoView;
@property (nonatomic,strong)discountModel *model;



@end
