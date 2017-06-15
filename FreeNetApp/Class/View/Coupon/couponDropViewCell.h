//
//  couponDropViewCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/5.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJDropModel.h"

@interface couponDropViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@property (nonatomic,strong) BHJDropModel *model;


@end
