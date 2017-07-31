//
//  HotRecommend.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "GoodsModel.h"

@interface HotRecommend : GoodsModel

@property (nonatomic,assign)int total;//多少人在抢
@property (nonatomic,strong)NSDictionary *shop_free;// 商品信息
@property (nonatomic,assign)NSInteger status;

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
