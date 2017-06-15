//
//  indianaCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/25.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndianaModel.h"
@interface indianaCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discuntPrice;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *pre_price;
@property (weak, nonatomic) IBOutlet UIButton *tryBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;

@property (nonatomic,strong)IndianaModel *model;



@end
