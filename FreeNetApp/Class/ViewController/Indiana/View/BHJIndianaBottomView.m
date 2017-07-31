//
//  BHJIndianaBottomView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/20.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "BHJIndianaBottomView.h"

@interface BHJIndianaBottomView ()

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation BHJIndianaBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(MainScreen_width / 2 - 30, - 20, 60, 60)];
        centerView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        centerView.cornerRadius = 30;
        [self addSubview:centerView];
        
        CALayer *testLayer = [CALayer layer];
        testLayer.backgroundColor = [UIColor clearColor].CGColor;
        testLayer.frame = CGRectMake(MainScreen_width / 2 - 30, -20, 60, 60);
        [self.layer addSublayer:testLayer];
        
        CAShapeLayer *solidLine =  [CAShapeLayer layer];
        solidLine.fillColor = [UIColor clearColor].CGColor;
        solidLine.strokeColor = [UIColor colorWithHexString:@"cdcdcd"].CGColor;
        solidLine.lineCap = kCALineCapRound;
        solidLine.lineWidth = 1;
        
        UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:29 startAngle:M_PI * 1.11 endAngle:M_PI * 1.89 clockwise:YES];
        solidLine.path = thePath.CGPath;
        [testLayer addSublayer:solidLine];
        
        CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath =  CGPathCreateMutable();
        [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [solidShapeLayer setStrokeColor:[[UIColor colorWithHexString:@"cdcdcd"] CGColor]];
        solidShapeLayer.lineWidth = 1.0f ;
        CGPathMoveToPoint(solidShapePath, NULL, 0, 0);
        CGPathAddLineToPoint(solidShapePath, NULL, centerView.left + 2,0);
        [solidShapeLayer setPath:solidShapePath];
        CGPathRelease(solidShapePath);
        [self.layer addSublayer:solidShapeLayer];
        
        CAShapeLayer *solidShapeLayer_1 = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath_1 =  CGPathCreateMutable();
        [solidShapeLayer_1 setFillColor:[[UIColor clearColor] CGColor]];
        [solidShapeLayer_1 setStrokeColor:[[UIColor colorWithHexString:@"cdcdcd"] CGColor]];
        solidShapeLayer_1.lineWidth = 1.0f ;
        CGPathMoveToPoint(solidShapePath_1, NULL, centerView.right - 2, 0);
        CGPathAddLineToPoint(solidShapePath_1, NULL, MainScreen_width,0);
        [solidShapeLayer_1 setPath:solidShapePath_1];
        CGPathRelease(solidShapePath_1);
        [self.layer addSublayer:solidShapeLayer_1];
        
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerBtn setFrame:CGRectMake(5, 5, 50, 50)];
        _centerBtn.cornerRadius = _centerBtn.width / 2;
        [_centerBtn setTitle:@"一键 \n 购买" forState:UIControlStateNormal];
        _centerBtn.titleLabel.numberOfLines = 0;
        [_centerBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _centerBtn.borderColor = [UIColor colorWithHexString:@"#e4504b"];
        _centerBtn.borderWidth = 5;
        _centerBtn.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
        [_centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _centerBtn.tag = 503;
        [_centerBtn addTarget:self action:@selector(bottomEvent:) forControlEvents:UIControlEventTouchUpInside];
        [centerView addSubview:_centerBtn];
        
        CGFloat btnWidth = (MainScreen_width - CGRectGetWidth(centerView.frame)) / 5;
        CGFloat btnHeight = CGRectGetHeight(self.frame);
        _historyButton = [[BHJTools sharedTools]creatButtonWithTitle:@"出价记录" image:@"berserk_1_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(10, 5, btnWidth, btnHeight - 8) viewController:nil selectedImage:@"berserk_1_selected" tag:500];
        [self addSubview:_historyButton];
        _secondButton = [[BHJTools sharedTools]creatButtonWithTitle:@"砸价" image:@"fire_gray" selector:@selector(bottomEvent:) Frame:CGRectMake(CGRectGetMaxX(centerView.frame) + 10, 5, btnWidth, btnHeight - 8) viewController:nil selectedImage:@"fire_red" tag:501];
        [self addSubview:_secondButton];
        _thirdButton = [[BHJTools sharedTools]creatButtonWithTitle:@"出价" image:@"charge_gray" selector:@selector(bottomEvent:) Frame:CGRectMake(MainScreen_width - btnWidth - 10, 5, btnWidth, btnHeight - 8) viewController:nil selectedImage:@"charge_red" tag:502];
        [self addSubview:_thirdButton];
    }
    return self;
}
//  底部按钮回调方法
-(void)bottomEvent:(JXButton *)sender{
    
    self.selectedBtn.selected = !self.selectedBtn.selected;
    sender.selected = !sender.selected;
    self.selectedBtn = sender;
    if (sender.selected) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(indianaBottomViewClick:)]) {
            [self.delegate indianaBottomViewClick:sender];
        }
    }else{
        return;
    }
}


@end
