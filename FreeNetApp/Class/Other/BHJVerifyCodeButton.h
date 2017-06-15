//
//  BHJVerifyCodeButton.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/15.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHJVerifyCodeButton : UIButton

// 由于有些时间需求不同，特意露出方法，倒计时时间次数
- (void)timeFailBeginFrom:(NSInteger)timeCount;

@property (nonatomic,assign) BOOL isClick;


@end
