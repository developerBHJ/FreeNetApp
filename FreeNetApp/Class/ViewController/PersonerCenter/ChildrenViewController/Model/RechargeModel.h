//
//  RechargeModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModel : NSObject


@property (nonatomic,strong)NSString *money;//支付金额

@property (nonatomic,strong)NSString *pay_time;//支付时间

@property (nonatomic,strong)NSString *pay_type;//支付方式

//@property (nonatomic,strong)NSString *      //银行卡号

@property (nonatomic,strong)NSString *is_pay;

@property (nonatomic,strong)NSNumber *rechargeId;
@end
