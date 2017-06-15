//
//  RestaurantViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,ViewStleWithData){

    ViewStleWithFreeData,
    ViewStleWithSpecialData,
    ViewStleWithIndianaData,
};

@interface RestaurantViewController : BHJViewController

@property (nonatomic,assign)ViewStleWithData viewStyle;
@property (nonatomic,assign)int class_id;


@end
