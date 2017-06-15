//
//  VerificationModeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "VerificationModeViewController.h"

@interface VerificationModeViewController ()

@property (nonatomic,strong)NSMutableArray *segementArray;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UIButton *payPwdBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneVerifyLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneVerifyBtn;
@property (weak, nonatomic) IBOutlet UILabel *customerServiceLabel;
@property (weak, nonatomic) IBOutlet UIButton *callPhoneBtn;

@end

@implementation VerificationModeViewController


#pragma mark - 懒加载
-(NSMutableArray *)segementArray{
    
    if (!_segementArray) {
        _segementArray = [NSMutableArray arrayWithArray:@[@"选择验证方式",@"验证"]];
    }
    return _segementArray;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setView];




}

#pragma mark - 自定义
-(void)setView{

    BHJSegementHeadView *headView = [[BHJSegementHeadView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44) titles:self.segementArray clickBlick:nil];
    headView.defaultIndex = 1;
    headView.separaterSpace = 5;
    headView.titleFont = [UIFont systemFontOfSize:12];
    headView.titleSelectColor = [UIColor colorWithHexString:@"#e4504b"];
    headView.titleNomalColor = [UIColor colorWithHexString:@"#696969"];
    [self.view addSubview:headView];
}

- (IBAction)pwdverify:(UIButton *)sender {
    
    NSLog(@"支付密码验证");
}

- (IBAction)phoneNumberVerify:(UIButton *)sender {
    

    
    NSLog(@"绑定手机号码验证");

}
- (IBAction)phoneVerify:(UIButton *)sender {
    

    NSLog(@"手机验证");
}
- (IBAction)customerService:(UIButton *)sender {
    

    NSLog(@"联系客服");
}




@end
