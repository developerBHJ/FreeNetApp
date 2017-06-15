//
//  shareCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shareCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


-(void)setCellWithModel:(PersonerGroup *)model;


@end
