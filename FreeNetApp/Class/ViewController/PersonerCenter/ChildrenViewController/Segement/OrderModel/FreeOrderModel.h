//
//  FreeOrderModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeOrderModel : GoodsModel

@property (nonatomic,strong)NSDictionary *user_free;
/*
 "id":"订单列表ID"
	"trade_no": "交易编号",
	"status": "订单状态 0为待领奖 1为已领奖 2为已弃奖 3为待收货 4为待评价 5为已完成"
	"created_at": "订单创建时间"
	"user_free": {
 "free_no":"开奖号码"
 "shop_free_plan":{
 "id": "免费产品计划表ID"
 "shop_free": {
 "cover_url": "封面图片"
 "title" : "商品名称"
 "price": "商品价格"
 "fee": "物流费用"
 }
 }
 
 
 {
 "id": 9,
 "trade_no": "2313433",
 "status": 0,
 "created_at": null,
 "user_free": {
 "free_no": 1231312323,
 "shop_free_plan": {
 "id": 1,
 "shop_free": {
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "啊剪刀手11",
 "price": "100.00",
 "fee": "50.00"
 }
 
 
 */
@end
