//
//  SearchModel.m
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/15.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.searchId = value;
    }
}



@end
