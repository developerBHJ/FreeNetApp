//
//  OpenRiceViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/14.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OpenRiceViewController.h"
#import "OpenRiceHistoryViewController.h"
#import "sharePlatformView.h"
#import "screenModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "BHJScreenView.h"
@interface OpenRiceViewController ()<BHJCustomViewDelegate>

@property (nonatomic,strong)NSMutableArray *screenData;
@property (nonatomic,strong)MBProgressHUD *progreeHUD;
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *handleView;
@property (weak, nonatomic) IBOutlet UIImageView *themeView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;


@end

@implementation OpenRiceViewController
#pragma mark >>>>>> 懒加载
-(NSMutableArray *)screenData{
    
    if (!_screenData) {
        
        screenModel *model1 = [[screenModel alloc]init];
        model1.theme = @"距离选择";
        model1.items = @[@"1公里",@"2公里",@"5公里",@"10公里",@"15公里"];
        screenModel *model2 = [[screenModel alloc]init];
        model2.theme = @"地图选择其他位置";
        model2.items = nil;
        screenModel *model3 = [[screenModel alloc]init];
        model3.theme = @"均价范围";
        model3.items = nil;
        screenModel *model4 = [[screenModel alloc]init];
        model4.theme = @"选择菜系";
        model4.items = nil;
        _screenData = [NSMutableArray arrayWithArray:@[model1,model2,model3,model4]];
    }
    return _screenData;
}

#pragma mark >>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}

#pragma mark - 摇动

/**
 *  摇动开始
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"开始摇了");
        self.progreeHUD = [[MBProgressHUD alloc]initWithView:self.view];
        self.progreeHUD.label.text = @"美食来了！";
        [self.progreeHUD showAnimated:YES];
        [self.view addSubview:self.progreeHUD];
        
        SystemSoundID soundId;
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Shake" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundId);
        AudioServicesPlaySystemSound(soundId);
        
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //设置抖动幅度
        shake.fromValue = [NSNumber numberWithFloat:-0.2];
        
        shake.toValue = [NSNumber numberWithFloat:+0.2];
        
        shake.duration = 0.2;
        
        shake.autoreverses = YES; //是否重复
        
        shake.repeatCount = 4;
        
        [self.handleView.layer addAnimation:shake forKey:@"imageView"];
        
        self.handleView.alpha = 1.0;
        
        //        [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
    }
}

/**
 *  摇动结束
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.progreeHUD hideAnimated:YES];
    NSLog(@"摇动结束");
}

/**
 *  摇动取消
 */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    NSLog(@"摇动取消");
}


#pragma mark >>>>>> 自定义
-(void)setView{
    
    self.navigationItem.title = @"开饭啦";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(set:)];
    self.centerView.cornerRadius = 95.5;
}

// 筛选
-(void)set:(UIBarButtonItem *)sender{
    
    BHJScreenView *screenView = [[BHJScreenView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    screenView.dataArr = self.screenData;
    screenView.delegate = self;
    [screenView showScreenViewSetCompletionBlock:^(int section, int row) {
        
        NSLog(@"Tag--->%d  %d",section,row);
    }];
}

// 分享
- (IBAction)shareAction:(UIButton *)sender {
    
    sharePlatformView *shareView = [sharePlatformView shareSharePlatformView];
    shareView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [shareView setView];
    } completion:^(BOOL finished) {
        
    }];
    [shareView returnButtonTag:^(NSInteger btnTag){
        NSLog(@"%ld",(long)btnTag);
    }];
}

- (IBAction)historyAction:(UIButton *)sender {
    
    OpenRiceHistoryViewController *historyVC = [[OpenRiceHistoryViewController alloc]init];
    [self.navigationController pushViewController:historyVC animated:YES];
}

#pragma mark >>>>>> BHJCustomViewDelegate
-(void)BHJCustomViewMethodWithButton:(UIButton *)sender{
    
    if (sender.tag == 1000) {
        NSLog(@"重置");
    }{
        NSLog(@"确定");
    }
}

@end
