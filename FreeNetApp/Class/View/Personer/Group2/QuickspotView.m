//
//  QuickspotView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "QuickspotView.h"

#define btnWidth MainScreen_width / 10
#define btnHeight MainScreen_height / 16
@implementation QuickspotView

-(NSMutableArray *)coordinates{
    
    if (!_coordinates) {
        
        CGPoint pt_0 = CGPointMake(56.6, 58.9);
        CGPoint pt_1 = CGPointMake(100.7, 14.5);
        CGPoint pt_2 = CGPointMake(100.7, 80.6);
        CGPoint pt_3 = CGPointMake(12.5, 36.6);
        CGPoint pt_4 = CGPointMake(56.6, 124.7);
        NSString *str_0 = NSStringFromCGPoint(pt_0);
        NSString *str_1 = NSStringFromCGPoint(pt_1);
        NSString *str_2 = NSStringFromCGPoint(pt_2);
        NSString *str_3 = NSStringFromCGPoint(pt_3);
        NSString *str_4 = NSStringFromCGPoint(pt_4);
        _coordinates = [NSMutableArray arrayWithObjects:str_0,str_1,str_2,str_3,str_4, nil];
    }
    return _coordinates;
}


-(void)viewDismiss{
    
    self.count = 0;
    self.countLabel.text = [NSString stringWithFormat:@"共 %ld/5 处不同",(long)self.count];
    for (UIView *subView in self.firstView.subviews) {
        [subView removeFromSuperview];
    }
    for (UIView *subView in self.secondView.subviews) {
        [subView removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (IBAction)closeAction:(UIButton *)sender {
    
    [self viewDismiss];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];

    }
    return self;
}


- (IBAction)dismiss:(UIButton *)sender {
    
    [self viewDismiss];
}

+(QuickspotView *)shareQuickspotView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"QuickspotView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJCustomViewMethodWithButton:)]) {
        [self.delegate BHJCustomViewMethodWithButton:sender];
    }
}


-(void)addButtonOnSubView:(UIView *)subView{
    
    if (MainScreen_height > 568) {
        for (int i = 0; i < 4; i ++) {
            for (int j = 0; j < 4; j ++) {
                UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tempBtn.frame = CGRectMake(btnWidth * i,btnHeight * j, btnWidth, btnHeight);
                [tempBtn addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
                tempBtn.timeInterval = 1000;
                [subView addSubview:tempBtn];
            }
        }
    }else{
        for (int i = 0; i < 4; i ++) {
            for (int j = 0; j < 4; j ++) {
                UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tempBtn.frame = CGRectMake(btnWidth * i,btnHeight * j, btnWidth, btnHeight);
                [tempBtn addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
                //                tempBtn.timeInterval = 60;
                [subView addSubview:tempBtn];
            }
        }
    }
}

-(void)btClick:(UIButton *)sender{
    
    UIView *supperView = [sender superview];
    CGFloat hScale = MainScreen_height / 568;
    CGFloat wScale = MainScreen_height / 320;
    if (supperView == self.firstView) {
        CGRect rect = sender.frame;
        BOOL isContaint = false;
        for (NSString *str in self.coordinates) {
            CGPoint pt = CGPointFromString(str);
            CGPoint targetPoint = CGPointMake(pt.x * wScale, pt.y * hScale);
            if (CGRectContainsPoint(rect,targetPoint)) {
                self.count ++;
                self.countLabel.text = [NSString stringWithFormat:@"共 %ld/5 处不同",(long)self.count];
                isContaint = true;
                break;
            }else{
                isContaint = false;
            }
        }
        if (isContaint) {
            [sender setBackgroundImage:[[UIImage imageNamed:@"topFun_right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            for (UIButton *button in self.secondView.subviews) {
                if (CGRectContainsPoint(button.frame, sender.frame.origin)) {
                    [button setBackgroundImage:[[UIImage imageNamed:@"topFun_right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    button.enabled = NO;
                }
            }
        }else{
            [sender setImage:[[UIImage imageNamed:@"topFun_wrong"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [sender setAlpha:0];
            // 闪屏效果
            [sender setAlpha:1];
            [UIView beginAnimations:@"flash screen" context:nil];
            [UIView setAnimationDuration:2.0f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [sender setAlpha:0.0f];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [UIView commitAnimations];
        }
        sender.enabled = NO;
    }
    if (supperView == self.secondView) {
        CGRect rect = sender.frame;
        BOOL isContaint = false;
        for (NSString *str in self.coordinates) {
            CGPoint pt = CGPointFromString(str);
            CGPoint targetPoint = CGPointMake(pt.x * wScale, pt.y * hScale);
            if (CGRectContainsPoint(rect, targetPoint)) {
                self.count ++;
                self.countLabel.text = [NSString stringWithFormat:@"共 %ld/5 处不同",(long)self.count];
                isContaint = true;
                break;
            }else{
                isContaint = false;
            }
        }
        if (isContaint) {
            [sender setBackgroundImage:[[UIImage imageNamed:@"topFun_right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            for (UIButton *button in self.firstView.subviews) {
                if (CGRectContainsPoint(button.frame, sender.frame.origin)) {
                    [button setBackgroundImage:[[UIImage imageNamed:@"topFun_right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    button.enabled = NO;
                }
            }
        }else{
            [sender setImage:[[UIImage imageNamed:@"topFun_wrong"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [sender setAlpha:0];
            // 闪屏效果
            [sender setAlpha:1];
            [UIView beginAnimations:@"flash screen" context:nil];
            [UIView setAnimationDuration:2.0f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [sender setAlpha:0.0f];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [UIView commitAnimations];
        }
        sender.enabled = NO;
    }
    if (self.count == 5) {
        self.firstView.userInteractionEnabled = NO;
        self.secondView.userInteractionEnabled = NO;
    }
}



@end
