//
//  AddAddressViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJViewController.h"



typedef NS_ENUM(NSInteger,AddressStyle) {
    
    AddressStyleAdd = 0,// 添加地址
    AddressStyleEdit = 1,// 编辑地址
};


@interface AddAddressViewController : BHJViewController

@property (nonatomic,strong)BaseModel *addressModel;
@property (nonatomic,assign)AddressStyle addressViewStyle;
@property (nonatomic,assign)NSInteger index;


@end
