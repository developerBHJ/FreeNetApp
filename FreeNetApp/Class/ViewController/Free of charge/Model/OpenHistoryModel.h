//
//  OpenHistoryModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/11.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenHistoryModel : GoodsModel

@property (nonatomic,strong)NSDictionary *shop_food_plan;
@property (nonatomic,strong)NSDictionary *user;
/*
 
 {
 "id": 2,
 "shop_food_plan": {
 "id": 1,
 "shop_food": {
 "id": 1,
 "cover_url": "http://oss.ktvgo.cn/avatars/default.png",
 "title": "11111",
 "shop": {
 "title": "克拉拉牛排"
 }
 }
 },
 "user": {
 "id": 1,
 "avatar_url": "http://icareu365.oss-cn-beijing.aliyuncs.com/avatars/a893028c8b2398318982df3573265a94.jpeg",
 "nickname": "haahha",
 "user_level": {
 "id": 1,
 "level": {
 "cover_url": "http://img1.skqkw.cn:888/2014/11/26/08/o5u1t2j2m3a-73633.jpg"
 }
 },
 "region": {
 "title": "西安市"
 }
 }
 }
 */
@end
