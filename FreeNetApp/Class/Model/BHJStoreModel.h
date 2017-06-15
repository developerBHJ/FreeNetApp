//
//  BHJStoreModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/2/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHJStoreModel : BaseModel

@property (nonatomic,strong)NSString *store_name;
@property (nonatomic,strong)NSString *store_address;
@property (nonatomic,strong)NSString *store_logo;


-(id)initWithName:(NSString *)name address:(NSString *)address logo:(NSString *)logo;

@end
