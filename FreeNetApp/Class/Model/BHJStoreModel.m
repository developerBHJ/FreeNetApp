//
//  BHJStoreModel.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/2/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "BHJStoreModel.h"

@implementation BHJStoreModel

-(id)initWithName:(NSString *)name address:(NSString *)address logo:(NSString *)logo{

    self = [super init];
    if (self) {
        self.store_name = name;
        self.store_address = address;
        self.store_logo = logo;
    }
    return self;
}



@end
