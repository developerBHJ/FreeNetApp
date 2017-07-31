//
//  BHJCustomBottomView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/19.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"


@protocol BHJCustomBottomViewDelegate <NSObject>

-(void)customBottomViewClick:(UIButton *)sender;

-(void)customBottomCenterViewClick;


@end

@interface BHJCustomBottomView : UIView

@property (nonatomic,assign)NSInteger totalTime;
@property (nonatomic,strong)MDRadialProgressView *progressView;
@property (nonatomic,strong)MDRadialProgressTheme *theme;
@property (nonatomic,strong)NSTimer *myTimer;

-(instancetype)initWithFrame:(CGRect)frame time:(NSInteger)totalTime;

@property (nonatomic,assign)id <BHJCustomBottomViewDelegate>delegate;

@property (nonatomic,assign)BOOL allowClick;

@end
