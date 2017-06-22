//
//  AttentionModel.m
//  FreeNetApp
//
//  Created by HanOBa on 2017/6/20.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "AttentionModel.h"

@implementation AttentionModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.shopId = value;
    }
    
}


@end
