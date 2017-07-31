//
//  OpenGoods.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/27.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenGoods : NSObject

@property (nonatomic,strong)NSDictionary *shop;
@property (nonatomic,strong)NSDictionary *goods;
@property (nonatomic,strong)NSArray *shop_food_plans;

/*
 {
 "status": 200,
 "message": "获取数据成功",
 "data": {
 "shop": {
 "id": 1,
 "title": "克拉拉牛排"
 },
 "goods": {
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "1231231a's'da's",
 "price": "0.00",
 "qty": 91,
 "shop_food_plans": [
 {
 "id": 2,
 "start_time": null,
 "end_time": null
 }
 ]
 }
 }
 }
 */
@end
