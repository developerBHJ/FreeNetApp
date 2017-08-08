//
//  BHJCustomBottomView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/19.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "BHJCustomBottomView.h"

@interface BHJCustomBottomView ()

// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic,strong)UITapGestureRecognizer *tapGR;
@property (nonatomic,strong)JXButton *historyButton;
@property (nonatomic,strong)JXButton *secondButton;
@property (nonatomic,strong)JXButton *thirdButton;
@property (nonatomic,strong)JXButton *fourthButton;


@end

@implementation BHJCustomBottomView

-(instancetype)initWithFrame:(CGRect)frame time:(NSInteger)totalTime{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.totalTime = totalTime;
        self.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        
        [self addObserver:self forKeyPath:@"allowClick" options:NSKeyValueObservingOptionNew || NSKeyValueChangeOldKey context:nil];
    }
    return self;
}

-(void)layoutSubviews{

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
    
    self.theme = [[MDRadialProgressTheme alloc] init];
    self.theme.incompletedColor = [UIColor colorWithRed:164/255.0 green:231/255.0 blue:134/255.0 alpha:1.0];
    self.theme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
    self.theme.sliceDividerHidden = YES;
    self.theme.labelShadowColor = [UIColor whiteColor];
    self.progressView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(5, 5, 50, 50) andTheme:self.theme];
    self.theme.labelColor = [UIColor colorWithHexString:@"#696969"];
    self.theme.completedColor = [UIColor colorWithHexString:@"#e4504b"];
    self.theme.incompletedColor = [UIColor colorWithHexString:@"#bebebe"];
    self.progressView.progressTotal = 1000;
    self.progressView.progressCounter = 0;
    
    self.progressView.label.text = @"未开始";
    [self.progressView.label setFont:[UIFont systemFontOfSize:12]];
    self.progressView.label.textColor = [UIColor greenColor];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerBtnClick:)];
    [self.progressView addGestureRecognizer:tapGR];
    [centerView addSubview:self.progressView];
    
    CGFloat btnWidth = (MainScreen_width - CGRectGetWidth(centerView.frame)) / 5;
    CGFloat btnHeight = CGRectGetHeight(self.frame);
    _historyButton = [[BHJTools sharedTools]creatButtonWithTitle:@"疯抢记录" image:@"berserk_1_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(10, 5, btnWidth, btnHeight - 8) viewController:nil selectedImage:@"berserk_1_selected" tag:500];
    [self addSubview:_historyButton];
    _secondButton = [[BHJTools sharedTools]creatButtonWithTitle:@"增加机会" image:@"berserk_2_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(CGRectGetMaxX(_historyButton.frame) + 10, 5, btnWidth, btnHeight - 8) viewController:nil selectedImage:@"berserk_2_selected" tag:501];
    [self addSubview:_secondButton];
    
    _thirdButton = [[BHJTools sharedTools]creatButtonWithTitle:@"直达50秒" image:@"berserk_3_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(MainScreen_width - btnWidth - 10, 5, btnWidth, btnHeight - 8) viewController:nil selectedImage:@"berserk_3_selected" tag:502];
    _thirdButton.enabled = NO;
    [self addSubview:_thirdButton];
    _fourthButton = [[BHJTools sharedTools]creatButtonWithTitle:@"直达30秒" image:@"berserk_4_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(CGRectGetMaxX(centerView.frame) + 10, 5, btnWidth, btnHeight - 8) viewController:nil selectedImage:@"berserk_4_selected" tag:503];
    _fourthButton.enabled = NO;
    [self addSubview:_fourthButton];
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    if ([keyPath isEqualToString:@"allowClick"]) {
        if (self.allowClick) {
            _historyButton.enabled = YES;
            _secondButton.enabled = YES;
            _tapGR.enabled = YES;
        }
    }
}

//  底部按钮回调方法
-(void)bottomEvent:(JXButton *)sender{
    
    if (self.allowClick) {
        self.selectedBtn.selected = !self.selectedBtn.selected;
        sender.selected = !sender.selected;
        self.selectedBtn = sender;
        if (sender.selected) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(customBottomViewClick:)]) {
                [self.delegate customBottomViewClick:sender];
            }
        }
    }else{
        return;
    }
}


-(void)centerBtnClick:(UITapGestureRecognizer *)sender{
    
    if (self.allowClick) {
        self.thirdButton.enabled = YES;
        self.fourthButton.enabled = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(customBottomCenterViewClick)]) {
            [self.delegate customBottomCenterViewClick];
        }
    }else{
        self.thirdButton.enabled = NO;
        self.fourthButton.enabled = NO;
    }
}

@end
