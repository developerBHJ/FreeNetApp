//
//  RechargeRecordModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/7.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeRecordModel : GoodsModel

/*
 {
 "id": 16,
 "type": 1,
 "total": 130,
 "created_at": "2017-08-07T09:14:37.000Z"
 },
 
 */
@property (nonatomic,strong)NSNumber *type;
@property (nonatomic,strong)NSNumber *total;



@end
