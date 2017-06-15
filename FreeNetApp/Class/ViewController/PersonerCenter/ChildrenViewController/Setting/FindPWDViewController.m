//
//  FindPWDViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "FindPWDViewController.h"
#import "VerificationModeViewController.h"
@interface FindPWDViewController ()

@property (nonatomic,strong)NSMutableArray *segementArray;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UITextField *user_nameTF;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UITextField *verificationTF;
@property (weak, nonatomic) IBOutlet UIButton *exchangeImage;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIImageView *verificationImage;

@end

@implementation FindPWDViewController

#pragma mark - 懒加载
-(NSMutableArray *)segementArray{

    if (!_segementArray) {
        _segementArray = [NSMutableArray arrayWithArray:@[@"确认帐号",@"选择验证方式",@"验证"]];
    }
    return _segementArray;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";

    [self setView];
    
}
#pragma mark - 自定义
-(void)setView{
    
    self.view.backgroundColor = HWColor(241, 241, 241, 1.0);

    BHJSegementHeadView *headView = [[BHJSegementHeadView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 42) titles:self.segementArray clickBlick:nil];
    headView.defaultIndex = 1;
    headView.separaterSpace = 15;
    headView.titleFont = [UIFont systemFontOfSize:12];
    headView.titleSelectColor = [UIColor colorWithHexString:@"#e4504b"];
    headView.titleNomalColor = [UIColor colorWithHexString:@"#696969"];
    [self.view addSubview:headView];
}


- (IBAction)nextAction:(UIButton *)sender {
    
    VerificationModeViewController *verificationModeVC = [[VerificationModeViewController alloc]init];
    verificationModeVC.navgationTitle = @"选择验证方式";
    [self.navigationController pushViewController:verificationModeVC animated:YES];
}


- (IBAction)exchangeImageAction:(UIButton *)sender {
    
    self.verificationImage.image = [[UIImage imageNamed:@"right"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
