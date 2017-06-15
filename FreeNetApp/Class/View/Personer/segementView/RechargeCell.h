//
//  RechargeCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *payment;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;



@end
