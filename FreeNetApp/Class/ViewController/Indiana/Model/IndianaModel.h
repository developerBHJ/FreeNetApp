//
//  IndianaModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "GoodsModel.h"

@interface IndianaModel : GoodsModel

@property (nonatomic,strong)NSDictionary *treasure;

/*
 {
	"id": "夺宝列表ID",
	"start_time": "开始时间"
	"end_time": "结束时间"
	"treasure" : {
 "id": "夺宝商品ID"
 "cover_url": "夺宝商品封面地址"
 "title": "夺宝商品名称"
 "price": "夺宝商品出售价格"
 "start_price": "夺宝商品起拍价格"
 }
 }
 
 {
 "status": 200,
 "message": "获取数据成功",
 "data": [
 {
 "id": 1,
 "start_time": "2017-06-07T19:52:00.000Z",
 "end_time": "2017-06-08T19:52:00.000Z",
 "treasure": {
 "id": 1,
 "cover_url": "http://oss.ktvgo.cn/avatars/default.png",
 "title": "这个是夺宝的商品名称",
 "start_price": "10.00",
 "price": "100.00"
 }
 },
 ]
 }
 
 */
@end
