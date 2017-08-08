//
//  SpecialOrder.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialOrder : GoodsModel

@property (nonatomic,strong)NSDictionary *shop_product;

/*
 "data": [
 {
 "id": 1,
 "created_at": null,
 "trade_no": "12313123",
 "status": 1,
 "shop_product": {
 "id": 1,
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "zhdshhs",
 "price": "100.00"
 }
 },
 {
 "id": 5,
 "created_at": "2017-07-26T03:17:06.000Z",
 "trade_no": "460417173111710",
 "status": 1,
 "shop_product": {
 "id": 1,
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "zhdshhs",
 "price": "100.00"
 }
 },
 {
 "id": 8,
 "created_at": "2017-07-28T07:09:14.000Z",
 "trade_no": "201795150995",
 "status": 1,
 "shop_product": {
 "id": 1,
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "zhdshhs",
 "price": "100.00"
 }
 }
 ]
 */

@end
