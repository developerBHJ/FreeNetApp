//
//  IndianaDetailViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/13.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndianaModel.h"
typedef NS_ENUM(NSInteger,DetailViewStatus) {
    
    DetailViewStatusWithNomal,
    DetailViewStatusWithWinning
};

@interface IndianaDetailViewController : BHJViewController

@property (nonatomic,assign)PageStatus detailState;

@property (nonatomic,strong)NSNumber *lid;

@end
