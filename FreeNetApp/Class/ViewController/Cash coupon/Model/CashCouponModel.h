//
//  CashCouponModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/28.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashCouponModel : GoodsModel

@property (nonatomic,strong)NSString *title;//标题
@property (nonatomic,strong)NSString *discount;//折扣价
@property (nonatomic,strong)NSString *price;//原价
@property (nonatomic,strong)NSString *selltotal;//已售数量
@property (nonatomic,strong)NSString *invater;//距离
@property (nonatomic,strong)NSDictionary *shop;
/*
 {
 "id": 1,
 "title": "呵呵呵呵",
 "price": "1233.00",
 "discount": "123.00",
 "status": true,
 "created_at": null,
 "updated_at": null,
 "deleted_at": null,
 "shop_id": 1,
 "selltotal": "2",
 "shop": {
 "id": 1,
 "title": "克拉拉牛排",
 "lng": "108.953636",
 "lat": "34.265731"
 },
 "invater": 7266.7
 },
 
 */
@end
