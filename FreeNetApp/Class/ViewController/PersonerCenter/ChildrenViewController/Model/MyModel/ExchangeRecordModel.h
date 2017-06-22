//
//  ExchangeRecordModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/6/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRecordModel : NSObject


@property (nonatomic,strong)NSNumber *exchangeId;   //ID

@property (nonatomic,strong)NSNumber *gold; //花费立免币

@property (nonatomic,strong)NSString *created_at;   //时间

@property (nonatomic,strong)NSNumber *coin; //兑换欢乐豆数

@end
