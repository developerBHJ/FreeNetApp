//
//  ExchangeRecordModel.m
//  FreeNetApp
//
//  Created by HanOBa on 2017/6/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "ExchangeRecordModel.h"

@implementation ExchangeRecordModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.exchangeId = value;
    }
}




@end
