//
//  MemeberModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/28.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemeberModel : GoodsModel

@property (nonatomic,strong)NSString *cover_url;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *recharge_min;
@property (nonatomic,strong)NSString *recharge_max;
@property (nonatomic,strong)NSString *consume_min;
@property (nonatomic,strong)NSString *consume_max;
@property (nonatomic,assign)int shop_id;
@property (nonatomic,strong)NSString *sellall;
@property (nonatomic,strong)NSDictionary *shop;


/*
 
 "data": {
 "id": 1,
 "cover_name": "",
 "cover_url": "http://oss.ktvgo.cn/avatars/default.png",
 "title": "这是会员VIP",
 "discount": "85.00",
 "recharge_min": "0.00",
 "recharge_max": "0.00",
 "consume_min": "0.00",
 "consume_max": "0.00",
 "shop_id": 1,
 "sellall": "2",
 "shop": {
 "id": 1,
 "title": "克拉拉牛排",
 "tel": "010-5796884",
 "address": "北京市海淀区大学路8牌9号"
 }
 }
 
 
 
 
 */
@end
