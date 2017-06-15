//
//  city.m
//  PickerView
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import "city.h"

@implementation city

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)citiesWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
