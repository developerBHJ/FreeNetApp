//
//  IndianaDetailModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/17.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "GoodsModel.h"

@interface IndianaDetailModel : GoodsModel

@property (nonatomic,strong)NSDictionary *treasure;
/*
 {
 "status": 200,
 "message": "获取数据成功",
 "data": {
 "id": 1,
 "start_time": "2017-06-07T19:52:00.000Z",
 "end_time": "2017-06-08T19:52:00.000Z",
 "treasure": {
 "id": 1,
 "title": "这个是夺宝的商品名称",
 "price": "100.00",
 "start_price": "10.00",
 "introduction": "这个是夺宝商品的描述\n",
 "treasure_images": [
 {
 "image_url": "http://oss.ktvgo.cn/avatars/default.png"
 }
 ]
 }
 }
 }
 
 */
@end
