//
//  OrderModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic,strong)NSNumber *orderId;      //商品ID

@property (nonatomic,strong)NSString *goods_name;   //商品名称

@property (nonatomic,strong)NSString *goods_price;  //商品价格

@property (nonatomic,strong)NSString *real_price;   //真实价格

@property (nonatomic,strong)NSString *pay_time;     //支付时间

@property (nonatomic,strong)NSString *img;          //图片

@end
