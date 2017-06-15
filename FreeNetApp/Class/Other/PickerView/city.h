//
//  city.h
//  PickerView
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface city : NSObject

@property (nonatomic,strong)NSArray *cities;
@property (nonatomic,copy)NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)citiesWithDic:(NSDictionary *)dic;

@end
