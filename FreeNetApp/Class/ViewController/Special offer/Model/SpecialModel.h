//
//  SpecialModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "GoodsModel.h"

@interface SpecialModel : GoodsModel

@property (nonatomic,strong)NSString *cover_url;
@property (nonatomic,strong)NSString *price;//原价
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *introduction;//描述
@property (nonatomic,strong)NSString *discount;// 折扣价
@property (nonatomic,strong)NSString *sell;//已售数量


/*
 {
 "id": 2,
 "cover_url": "http://oss.ktvgo.cn/avatars/default.png",
 "title": "哈哈是",
 "price": "100.00",
 "introduction": "在这个是啥子哟\n",
 "shop": {
 "id": 1
 }
 
 
 */

@end
