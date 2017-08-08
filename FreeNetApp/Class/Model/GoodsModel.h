//
//  GoodsModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic,strong)NSNumber *id;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *start_time;

@property (nonatomic,strong)NSString *trade_no;//交易编号
@property (nonatomic,strong)NSString *created_at;//创建时间
@property (nonatomic,strong)NSNumber *status;//"订单状态 0为待领奖 1为已领奖 2为已弃奖 3为待收货 4为待评价 5为已完成"

/*
 {
 "status": 200,
 "message": "数据获取成功",
 "data": [
 {
 "id": 2,
 "start_time": "2017-06-07T19:52:00.000Z",
 "end_time": "2017-06-09T19:52:00.000Z",
 "is_hot": true,
 "status": false,
 "total": "2",
 "created_at": null,
 "updated_at": null,
 "shop_free_id": 2,
 "shop_free": {
 "cover_url": "https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=美食图片&step_word=&hs=2&pn=24&spn=0&d",
 "title": "生活啦",
 "price": "100.00",
 "shop": {
 "id": 1
 }
 }
 }
 ]
 
 */
@end
