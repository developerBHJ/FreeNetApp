//
//  OrderDetailViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

typedef NS_ENUM(NSInteger,OrderDetailStatus) {

    isFinished,
    receiving,
    isReceived

};

@interface OrderDetailViewController : BHJViewController

@property (nonatomic,strong)OrderModel *orderM;
@property (nonatomic,assign)OrderDetailStatus orderStyle;

@end
