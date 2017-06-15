//
//  BerserkCell_2.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/8.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BerserkCell_2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *prcieLabel;
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *time_h1;
@property (weak, nonatomic) IBOutlet UILabel *time_h2;
@property (weak, nonatomic) IBOutlet UILabel *time_m1;
@property (weak, nonatomic) IBOutlet UILabel *time_m2;
@property (weak, nonatomic) IBOutlet UILabel *time_s1;
@property (weak, nonatomic) IBOutlet UILabel *time_s2;

@property (nonatomic,strong)NSTimer *timerNow;

@end
