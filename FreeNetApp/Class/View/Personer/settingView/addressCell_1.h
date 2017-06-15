//
//  addressCell_1.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface addressCell_1 : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *defalutBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;


@property (nonatomic,strong)AddressModel *model;
@end
