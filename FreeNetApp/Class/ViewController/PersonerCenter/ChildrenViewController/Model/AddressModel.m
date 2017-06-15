//
//  AddressModel.m
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.addressId = value;
    }
}


@end
