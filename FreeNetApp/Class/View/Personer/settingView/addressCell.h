//
//  addressCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface addressCell : BaseCollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_phone;
@property (weak, nonatomic) IBOutlet UILabel *user_address;

@property (nonatomic,strong)AddressModel *model;

@end
