//
//  myExchangeCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface myExchangeCell : BaseTableViewCell

@property (nonatomic,strong)OrderModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *goods_image;

@property (weak, nonatomic) IBOutlet UILabel *goods_name;

@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *markLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
