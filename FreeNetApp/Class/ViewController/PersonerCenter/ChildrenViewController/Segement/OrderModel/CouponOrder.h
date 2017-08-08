//
//  CouponOrder.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponOrder : GoodsModel

@property (nonatomic,strong)NSDictionary *shop_coupon;

/*
 data": [
 {
 "id": 1,
 "trade_no": "174031540459111",
 "serial": "30704704",
 "status": 1,
 "created_at": "2017-07-26T07:40:45.000Z",
 "shop_coupon": {
 "id": 1,
 "title": "呵呵呵呵",
 "price": "1233.00",
 "discount": "7.50",
 "status": true,
 "cover": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "over_time": "2017-07-12 - 2017-12-12",
 "shop": {
 "id": 1,
 "title": "克拉拉牛排",
 "address": "北京市海淀区大学路8牌9号",
 "lng": "108.953636",
 "lat": "34.265731"
 }
 }
 */

@end
