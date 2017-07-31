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
#import "OpenModel.h"
#import "OpenGoods.h"

#define kOpenUrl @"http://192.168.0.254:4004/publics/firstshow"
#define kGoodsUrl @"http://192.168.0.254:4004/publics/food_detail"
@interface OpenRiceViewController ()<BHJCustomViewDelegate>

@property (nonatomic,strong)NSMutableArray *screenData;
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *handleView;
@property (weak, nonatomic) IBOutlet UIImageView *themeView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (nonatomic, strong) OpenModel *model;
@property (nonatomic, strong) OpenGoods *product;
@property (nonatomic,strong)OpenRiceHistoryViewController *historyVC;
@property (nonatomic,strong)sharePlatformView *productView;
@property (nonatomic,strong)NSMutableDictionary *paramater;

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

-(sharePlatformView *)productView{
    
    if (!_productView) {
        _productView = [sharePlatformView shareSharePlatformView];
        _productView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    return _productView;
}

-(NSMutableDictionary *)paramater{

    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"region_id",@"1",@"userId", nil];
    }
    return _paramater;
}
#pragma mark >>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDataWithUrl:kOpenUrl paramater:self.paramater];
    [self setView];
}

#pragma mark - 摇动

/**
 *  摇动开始
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake) {
        
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
        
        [self shareAction:self.shareBtn];
    }
}

/**
 *  摇动结束
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self.paramater setValue:@"1" forKey:@"cid"];
    [self requestGoodsDataWithUrl:kGoodsUrl paramater:self.paramater];
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
    
    
}

- (IBAction)historyAction:(UIButton *)sender {
    
    [self.navigationController pushViewController:self.historyVC animated:YES];
}

/**
 获取开饭啦数据
 
 @param url 数据网址
 @param paramater 参数
 */
-(void)requestDataWithUrl:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        weak.model = [OpenModel mj_objectWithKeyValues:responseObject[@"data"]];
        weak.themeLabel.text = weak.model.shop[@"title"];
        weak.subTitle.text = [NSString stringWithFormat:@"%@邀请全市人民吃饭",weak.model.shop[@"title"]];
        NSString *title = [NSString stringWithFormat:@"仅有%@份哦，先到先得",weak.model.counts[@"counts"]];
        [weak.bottomBtn setTitle:title forState:UIControlStateNormal];
        
      //  [weak.paramater setValue:weak.model.shop[@"id"] forKey:@"cid"];
        
        weak.historyVC = [[OpenRiceHistoryViewController alloc]initWithLid:weak.model.counts[@"id"]];
    } failure:^(NSError * _Nullable error) {
        
    }];
}


/**
 摇一摇商品信息
 
 @param url 摇一摇URL
 @param paramater 参数
 */
-(void)requestGoodsDataWithUrl:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        if ([responseObject[@"status"] integerValue] == 200) {
            weak.product = [OpenGoods mj_objectWithKeyValues:responseObject[@"data"]];
            weak.productView.product = weak.product;
            [_productView returnButtonTag:^(NSInteger btnTag){
                NSLog(@"%ld",(long)btnTag);
            }];
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [weak.productView setView];
            } completion:^(BOOL finished) {
                [weak.productView returnButtonTag:^(NSInteger btnTag) {
                    NSLog(@"%ld",btnTag);
                }];
            }];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
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
