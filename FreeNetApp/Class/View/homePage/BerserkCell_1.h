//
//  BerserkCell_1.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/8.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRecommend.h"
typedef NS_ENUM(NSInteger,cellStatus) {
    
    cellStatusWithNomal,
    cellStatusWithLead,
    cellStatusWithWinning
};

@interface BerserkCell_1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@property (nonatomic,strong)NSTimer *timerNow;
@property (nonatomic,assign)cellStatus status;
@property (nonatomic,strong)HotRecommend *model;

@end
