//
//  IndianaModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "GoodsModel.h"

@interface IndianaModel : GoodsModel

@property (nonatomic,strong)NSString *purchase_price;
@property (nonatomic,strong)NSString *snatch_price;

/*
 {
 id  夺宝表ID
 name 夺宝名称
 purchase_price  直购价格
 snatch_price  夺宝价格
 img  商品图片
 }
 
 
 */
@end
