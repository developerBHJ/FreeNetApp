//
//  PersonerFreeViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BHJViewStyle) {
    
    BHJViewStyleWithFree,
    BHJViewStyleWithIndiana,
    BHJViewStyleWithSpecial,
    BHJViewStyleWithCoupon,
    BHJViewStyleWithOpen,
};

@interface PersonerFreeViewController : BHJViewController

@property (nonatomic,assign)BHJViewStyle status;


@end
