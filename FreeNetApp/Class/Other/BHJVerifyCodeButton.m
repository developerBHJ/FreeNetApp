//
//  BHJVerifyCodeButton.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/15.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJVerifyCodeButton.h"

@interface BHJVerifyCodeButton ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation BHJVerifyCodeButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self setTitle:@" 获取验证码 " forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 3.0;
    self.clipsToBounds = YES;
//    [self setTitleColor:HWColor(128, 177, 34, 1.0) forState:UIControlStateNormal];
//    self.layer.borderColor = HWColor(128, 177, 34, 1.0).CGColor;
//    self.layer.borderWidth = 1.0;
}

- (void)timeFailBeginFrom:(NSInteger)timeCount {
    
    self.count = timeCount;
    self.enabled = NO;
    // 加1个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)timerFired {
    
    if (self.count != 1) {
        self.count -= 1;
        [self setTitle:[NSString stringWithFormat:@"(%ld)重新获取", (long)self.count] forState:UIControlStateDisabled];
    } else {
        self.enabled = YES;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        //        self.count = 60;
        [self.timer invalidate];
    }
}


@end
