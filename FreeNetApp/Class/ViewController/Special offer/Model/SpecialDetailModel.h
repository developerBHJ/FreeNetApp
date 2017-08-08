//
//  SpecialDetailModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/29.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialDetailModel : GoodsModel


@property (nonatomic,strong)NSString *cover_url;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,assign)int sell;
@property (nonatomic,assign)int qty;
@property (nonatomic,strong)NSString *introduction;
@property (nonatomic,assign)BOOL is_appointment;// "是否支持免预约 true为是 false为否"
@property (nonatomic,assign)BOOL is_return;// "是否支持随时退 true为是 false为否"
@property (nonatomic,assign)BOOL is_hot;//
@property (nonatomic,assign)BOOL is_expired_return;// 是否支持过期退 true为是 false为否"
@property (nonatomic,assign)BOOL status;//
@property (nonatomic,strong)NSString *paytotal;//购买总人数
@property (nonatomic,strong)NSArray *shop_product_images;
@property (nonatomic,strong)NSDictionary *shop;


/*
 "data": [
 {
 "id": 1,
 "cover_name": "",
 "cover_url": "http://oss.ktvgo.cn/avatars/default.png",
 "title": "zhdshhs",
 "price": "100.00",
 "discount": "90.00",
 "sell": 100,
 "qty": 200,
 "introduction": "按时大大所多 ",
 "is_appointment": true,
 "is_hot": true,
 "is_return": true,
 "is_expired_return": true,
 "status": true,
 "created_at": null,
 "updated_at": null,
 "deleted_at": null,
 "catelog_id": null,
 "shop_id": 1,
 "paytotal": "1",
 "shop_product_images": [
 {
 "id": 2,
 "image_url": "http://oss.ktvgo.cn/avatars/default.png"
 },
 {
 "id": 3,
 "image_url": "http://oss.ktvgo.cn/avatars/default.png"
 }
 ],
 "shop": {
 "id": 1,
 "title": "克拉拉牛排",
 "rate": 3
 }
 }
 ]
 }
 */
@end
