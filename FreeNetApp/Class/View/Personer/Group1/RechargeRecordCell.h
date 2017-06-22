//
//  RechargeRecordCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeRecordModel.h"

@interface RechargeRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *payment;  //支付方式

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;  //充值钱数

@property (weak, nonatomic) IBOutlet UIImageView *timeImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间

@property (nonatomic,strong)ExchangeRecordModel *model;
@end


