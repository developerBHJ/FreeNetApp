//
//  OrderModel.m
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.orderId = value;
    }
}

@end
