//
//  specialDetailCell_2.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialModel.h"
@interface specialDetailCell_2 : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *prePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;
@property (weak, nonatomic) IBOutlet UIImageView *leftView;


@property (nonatomic,strong)SpecialModel *model;





@end
