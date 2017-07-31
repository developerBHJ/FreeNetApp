//
//  OpenModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/11.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenModel : GoodsModel

@property (nonatomic,strong)NSDictionary *shop;
@property (nonatomic,strong)NSDictionary *counts;

/*
 "data": {
 "shop": {
 "id": 2,
 "title": "黄焖鸡"
 },
 "counts": {
 "id": 1,
 "cover_name": "123",
 "cover_url": "http://oss.ktvgo.cn/avatars/default.png",
 "title": "11111",
 "price": "0.00",
 "qty": 94,
 "is_hot": true,
 "status": true,
 "created_at": null,
 "updated_at": "2017-06-13T07:00:57.000Z",
 "shop_id": 1,
 "counts": "4"
 }
 }
 */

@end
