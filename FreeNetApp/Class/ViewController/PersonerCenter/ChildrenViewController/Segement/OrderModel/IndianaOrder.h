//
//  IndianaOrder.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndianaOrder : GoodsModel

@property (nonatomic,strong)NSString *total;//支付立免币金额
@property (nonatomic,strong)NSString *shippment_no;//物流单号
//订单状态: 0为未付款 1为已付款待发货 2为待收货已发货 3为已收货待评价 4为已完成 5为已取消"
@property (nonatomic,strong)NSDictionary *user_treasure;


/*
 "data": [
 {
 "id": 1,
 "trade_no": "425141751415513",
 "total": "1.00",
 "shippment_no": null,
 "status": 1,
 "created_at": "2017-07-27T07:51:30.000Z",
 "user_treasure": {
 "id": 1,
 "treasure_plan": {
 "id": 1,
 "treasure": {
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "这个是夺宝的商品名称",
 "price": "88.99"
 }
 }
 }
 }
 */
@end
