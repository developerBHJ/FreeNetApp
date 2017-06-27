//
//  BerserkViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRecommend.h"

typedef NS_ENUM(NSInteger,PageStatus) {

    PageStatueWithNomal,
    PageStatueWithLead,
    PageStatueWithWinning
};
@interface BerserkViewController : BHJViewController

@property (nonatomic,assign)PageStatus pageState;

@property (nonatomic,strong)GoodsModel *model;

@end
