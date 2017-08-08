//
//  ExchangeRecordModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/6/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRecordModel : GoodsModel

/*
 {
 "id": 1,
 "gold": 10,
 "created_at": "2017-06-15T07:55:47.000Z",
 "coin": 1000
 },
 
 */

@property (nonatomic,strong)NSNumber *gold; //花费立免币

@property (nonatomic,strong)NSNumber *coin; //兑换欢乐豆数

@end
