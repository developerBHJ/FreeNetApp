//
//  CalendarViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "CalendarViewController.h"
#import "BHJCalendarView.h"
#import <AudioToolbox/AudioToolbox.h>
@interface CalendarViewController ()

@property (nonatomic,strong)BHJCalendarView *calendarView;
@property (nonatomic,strong)UIScrollView *backView;
@property (nonatomic,strong)MBProgressHUD *progreeHUD;


@end

@implementation CalendarViewController

+ (CalendarViewController *)sharedCalendarViewController{

    static CalendarViewController *calendarVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendarVC = [[CalendarViewController alloc]init];
    });
    return calendarVC;
}

#pragma mark >>>> 懒加载
-(BHJCalendarView *)calendarView{

    if (!_calendarView) {
        _calendarView = [[BHJCalendarView alloc]initWithFrame:CGRectMake(12.5, kScreenHeight / 2.83, kScreenWidth - 25, kScreenHeight / 2.15)];
    }
    return _calendarView;
}

-(UIScrollView *)backView{

    if (!_backView) {
        _backView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _backView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 1.2);
        _backView.showsVerticalScrollIndicator = NO;
        _backView.showsHorizontalScrollIndicator = NO;
        _backView.bouncesZoom = NO;
    }
    return _backView;
}
#pragma mark >>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUp];
    
}

#pragma mark - 摇动

/**
 *  摇动开始
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"开始摇了");
        self.progreeHUD = [[MBProgressHUD alloc]initWithView:self.view];
        self.progreeHUD.label.text = @"签到成功！";
        [self.progreeHUD showAnimated:YES];
        [self.calendarView setStyle_Today_Signed:self.calendarView.dayButton];
        [self.view addSubview:self.progreeHUD];
        
        SystemSoundID soundId;
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Shake" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundId);
        AudioServicesPlaySystemSound(soundId);
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

#pragma mark >>>> 自定义
-(void)setUp{

    [self.view addSubview:self.backView];
    [self.backView addSubview:self.calendarView];
    self.navigationItem.title = @"签到";

    UIView *markView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarView.frame) + 12, kScreenWidth, 1)];
    markView.backgroundColor = HWColor(190, 190, 190, 1.0);
    [self.backView addSubview:markView];
    UIImageView *rockView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rock"]];
    rockView.frame = CGRectMake(kScreenWidth / 3, 26, kScreenWidth / 3, kScreenWidth / 3);
    
    [self.backView addSubview:rockView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(rockView.frame), CGRectGetMaxY(rockView.frame) + 15, kScreenWidth / 3, 21)];
    titleLabel.text = @"摇一摇签到";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.backView addSubview:titleLabel];
    
    UILabel *ruleTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.calendarView.frame), CGRectGetMaxY(markView.frame) + 15, kScreenWidth - 25, 21)];
    ruleTitle.text = @"签到规则";
    [ruleTitle setFont:[UIFont systemFontOfSize:12]];
    [self.backView addSubview:ruleTitle];
    NSArray *titleArr = @[@"1、 每天获得等同于连续签到价值的欢乐豆",@"2、 连续签到365天的，每天可获得365个欢乐豆",@"3、 如中途未成功签到，则连续签到天数重新计算",@"4、 为了更好的用户体验，立免网可能对签到功能和",@"      规则进行调整，请小伙伴及时关注。"];
    for (int i = 0; i < titleArr.count; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12.5, CGRectGetMaxY(ruleTitle.frame) + 15 + 30 * i, kScreenWidth - 25, 30)];
        label.text = titleArr[i];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.numberOfLines = 0;
        [label setFont:[UIFont systemFontOfSize:12]];
        [self.backView addSubview:label];
    }

    //设置已经签到的天数日期
    NSMutableArray* _signArray = [[NSMutableArray alloc] init];
    [_signArray addObject:[NSNumber numberWithInt:1]];
    [_signArray addObject:[NSNumber numberWithInt:5]];
    [_signArray addObject:[NSNumber numberWithInt:9]];
    self.calendarView.signArray = _signArray;
    self.calendarView.date = [NSDate date];

    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    //日期点击事件
    __weak typeof(BHJCalendarView) *weakDemo = self.calendarView;
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        if ([comp day]==day) {
            NSLog(@"%li-%li-%li", (long)year,month,day);
            //根据自己逻辑条件 设置今日已经签到的style 没有签到不需要写
            [weakDemo setStyle_Today_Signed:weakDemo.dayButton];
        }
    };
}

@end
