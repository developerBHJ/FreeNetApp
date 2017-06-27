//
//  OrderDetailBottomView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BottomViewStyle) {

    isOne,
    isTwo
};

@interface OrderDetailBottomView : BHJCustomView

@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;

@property (nonatomic,assign)BottomViewStyle viewStyle;



@end
