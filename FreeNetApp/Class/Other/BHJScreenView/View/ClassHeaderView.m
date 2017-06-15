//
//  ClassHeaderView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/3/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "ClassHeaderView.h"
#import "UIView+SetRect.h"
#import "screenModel.h"
@interface ClassHeaderView ()

@property (nonatomic, strong) UIButton   *button;
@property (nonatomic, strong) RotateView *rotateView;

@property (nonatomic, strong) UILabel    *normalClassNameLabel;
@property (nonatomic, strong) UILabel    *highClassNameLabel;

@end
@implementation ClassHeaderView

- (void)buildSubview {
    
    // 白色背景
    UIView *backgroundView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    // 灰色背景
    UIView *contentView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    [self addSubview:contentView];
    
    UIView *line2         = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width - 20, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
    [contentView addSubview:line2];
    // 按钮
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    [self.button addTarget:self
                    action:@selector(buttonEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    // 旋转的view
    self.rotateView                = [[RotateView alloc] initWithFrame:CGRectMake(Width - 50, 12, 20, 20)];
    self.rotateView.rotateDuration = 0.25f;
    [self addSubview:self.rotateView];
    // 箭头图片
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 15, 15)];
    arrowImageView.image        = [UIImage imageNamed:@"next"];
    arrowImageView.center       = self.rotateView.middlePoint;
    [self.rotateView addSubview:arrowImageView];
    
    
    self.normalClassNameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 44)];
    self.normalClassNameLabel.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:self.normalClassNameLabel];
    
    self.highClassNameLabel           = [[UILabel alloc] initWithFrame:self.normalClassNameLabel.frame];
    self.highClassNameLabel.font      = self.normalClassNameLabel.font;
    self.highClassNameLabel.textColor = [UIColor redColor];
    [contentView addSubview:self.highClassNameLabel];
}

- (void)buttonEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customHeaderFooterView:event:)]) {
        
        [self.delegate customHeaderFooterView:self event:nil];
    }
}

- (void)loadContent {
    
    screenModel *model = self.data;
    
    _normalClassNameLabel.text = model.theme;
    _highClassNameLabel.text   = model.theme;
}

- (void)normalStateAnimated:(BOOL)animated {
    
    [self.rotateView changeToUpAnimated:animated];
    
    if (animated == YES) {
        
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _normalClassNameLabel.alpha = 1.f;
            _normalClassNameLabel.frame = CGRectMake(10, 0, 150, 44);
            _highClassNameLabel.alpha   = 0.f;
            _highClassNameLabel.frame   = CGRectMake(10, 0, 150, 44);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        
        _normalClassNameLabel.alpha = 1.f;
        _normalClassNameLabel.frame = CGRectMake(10, 0, 150, 44);
        _highClassNameLabel.alpha   = 0.f;
        _highClassNameLabel.frame   = CGRectMake(10, 0, 150, 44);
    }
}

- (void)extendStateAnimated:(BOOL)animated {
    
    [self.rotateView changeToRightAnimated:animated];
    
    if (animated == YES) {
        
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _normalClassNameLabel.alpha = 0.f;
            _normalClassNameLabel.frame = CGRectMake(10 + 10, 0, 150, 44);
            _highClassNameLabel.alpha   = 1.f;
            _highClassNameLabel.frame   = CGRectMake(10 + 10, 0, 150, 44);
            
        } completion:^(BOOL finished) {
            
        }];
    } else {
        _normalClassNameLabel.alpha = 0.f;
        _normalClassNameLabel.frame = CGRectMake(10 + 10, 0, 150, 44);
        _highClassNameLabel.alpha   = 1.f;
        _highClassNameLabel.frame   = CGRectMake(10 + 10, 0, 150, 40);
    }
}


@end
