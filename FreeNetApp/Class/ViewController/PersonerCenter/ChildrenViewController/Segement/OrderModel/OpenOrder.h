//
//  OpenOrder.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenOrder : GoodsModel

@property (nonatomic,strong)NSDictionary *user_food;
/*
 data": [
 {
 "id": 1,
 "trade_no": "170802154846947",
 "serial": "95278248",
 "status": 1,
 "created_at": "2017-08-02T07:48:46.000Z",
 "user_food": {
 "id": 49,
 "coin": 1,
 "shop_food_plan": {
 "id": 1,
 "shop_food": {
 "id": 1,
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "11111",
 "price": "0.00"
 }
 }
 }
 }
 ]
 */

@end
