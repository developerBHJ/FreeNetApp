//
//  OtherCouponModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherCouponModel : GoodsModel

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *lng;
@property (nonatomic,strong)NSString *lat;
@property (nonatomic,strong)NSString *invater;
@property (nonatomic,strong)NSArray *shop_coupons;

/*
 {
 "id": 2,
 "title": "黄焖鸡",
 "lng": "108.953996",
 "lat": "34.323947",
 "shop_coupons": [],
 "invater": 996.8
 },
 
 */
@end
