//
//  BHJCustomView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BHJCustomViewDelegate <NSObject>

@optional
-(void)BHJCustomViewMethodWithButton:(UIButton *)sender;


@end

@interface BHJCustomView : UIView

@property (nonatomic,assign)id <BHJCustomViewDelegate> delegate;


@end
