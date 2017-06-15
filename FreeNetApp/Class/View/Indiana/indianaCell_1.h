//
//  indianaCell_1.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/25.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndianaModel.h"
@interface indianaCell_1 : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discuntPrice;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *prePrice;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *tryBtn;


@property (nonatomic,strong)IndianaModel *model;





@end
