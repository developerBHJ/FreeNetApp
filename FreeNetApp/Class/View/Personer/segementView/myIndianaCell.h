//
//  myIndianaCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface myIndianaCell : BaseTableViewCell

@property (nonatomic,strong)OrderModel *model;

@property (weak, nonatomic) IBOutlet UILabel *goods_name;

@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@property (weak, nonatomic) IBOutlet UILabel *currentPrice;

@property (weak, nonatomic) IBOutlet UILabel *topPrice;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *goods_image;

@property (weak, nonatomic) IBOutlet UIButton *behaviorBtn;

@property (weak, nonatomic) IBOutlet UICustomLineLabel *prePrice;

@end
