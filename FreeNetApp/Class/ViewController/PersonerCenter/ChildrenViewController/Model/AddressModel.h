//
//  AddressModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic,strong)NSNumber *addressId;    //ID

@property (nonatomic,strong)NSString *realname;     //姓名

@property (nonatomic,strong)NSString *mobile;       //电话号

@property (nonatomic,strong)NSString *province_name;    //省

@property (nonatomic,strong)NSString *city_name;        //市

@property (nonatomic,strong)NSString *district_name;    //区

@property (nonatomic,strong)NSString *address;          //详细地址

@end
