//
//  IndianaDetailModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/17.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "GoodsModel.h"

@interface IndianaDetailModel : GoodsModel

@property (nonatomic,strong)NSString *purchase_price;
@property (nonatomic,strong)NSString *snatch_price;
@property (nonatomic,strong)NSArray *images;

@end
