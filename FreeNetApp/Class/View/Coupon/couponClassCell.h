//
//  couponClassCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJDropModel.h"
@interface couponClassCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;

@property (nonatomic,strong) BHJDropModel *model;

@end
