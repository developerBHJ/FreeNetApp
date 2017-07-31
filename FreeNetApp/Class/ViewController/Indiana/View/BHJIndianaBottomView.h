//
//  BHJIndianaBottomView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/20.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BHJIndianaBottomViewDelegate <NSObject>

-(void)indianaBottomViewClick:(UIButton *)sender;

@end

@interface BHJIndianaBottomView : UIView

@property (nonatomic,strong)UIButton *centerBtn;
@property (nonatomic,strong)JXButton *historyButton;
@property (nonatomic,strong)JXButton *secondButton;
@property (nonatomic,strong)JXButton *thirdButton;

@property (nonatomic,assign)id <BHJIndianaBottomViewDelegate>delegate;

@end
