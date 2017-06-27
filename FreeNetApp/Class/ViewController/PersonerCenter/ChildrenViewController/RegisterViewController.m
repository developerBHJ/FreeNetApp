//
//  RegisterViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerificationViewController.h"
#import "FreeNetUserDelegateViewController.h"

@interface RegisterViewController ()

@property (nonatomic,strong)NSMutableArray *segenmentArray;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *delegateBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userPhone;
@property (weak, nonatomic) IBOutlet UIImageView *userKey;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *voditification;
@property (weak, nonatomic) IBOutlet UIImageView *voditify;
@property (weak, nonatomic) IBOutlet BHJVerifyCodeButton *voditificationBtn;


@end

@implementation RegisterViewController



#pragma mark - Init
-(NSMutableArray *)segenmentArray{
    
    if (!_segenmentArray) {
        _segenmentArray = [NSMutableArray arrayWithArray:@[@"1 输入手机号",@"2 输入验证码",@"3 设置密码"]];
    }
    return _segenmentArray;
}



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = HWColor(241, 241, 241, 1.0);
    
    
}



#pragma mark - 同意协议按钮
- (IBAction)selectedAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundImage:[[UIImage imageNamed:@"selected_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    }else{
        [sender setBackgroundImage:[[UIImage imageNamed:@"nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    }
}



#pragma mark - 获取验证码
- (IBAction)getVerification:(UIButton *)sender {
    
    if (self.phoneNumber.text.length && self.phoneNumber.text.length == 11) {
        
        NSString *url = [NSString stringWithFormat:@"http://192.168.0.254:4004/sso/sms/%@",self.phoneNumber.text];
        [self fetchVerificationCodeWithURL:url];
        
        [self.voditificationBtn timeFailBeginFrom:60];  // 倒计时60s

    }else{
        
        [ShowMessage showMessage:@"手机号码格式错误" duration:3];
    }
}



#pragma mark - 阅读协议
- (IBAction)freeNetDelegate:(UIButton *)sender {
    
    FreeNetUserDelegateViewController *userDelegateVC = [[FreeNetUserDelegateViewController alloc]init];
    [self.navigationController pushViewController:userDelegateVC animated:YES];
}



#pragma mark - 注册
- (IBAction)nextAction:(UIButton *)sender {

    
    if (!self.phoneNumber.text.length || self.phoneNumber.text.length != 11) {

        [ShowMessage showMessage:@"手机号码错误" duration:3];
        return;
    }
    if (!self.pwdTF.text.length) {

        [ShowMessage showMessage:@"密码不能为空" duration:3];
        return;
    }
    if (!self.voditification.text.length) {

        [ShowMessage showMessage:@"验证码不能为空" duration:3];
        return;
    }
    
    [self registActionWithURL:API_URL(@"/sso/users/signup")];
}



#pragma mark - 注册响应
-(void)registActionWithURL:(NSString *)url{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.phoneNumber.text forKey:@"mobile"];
    [parameter setValue:self.voditification.text forKey:@"sms"];
    [parameter setValue:self.pwdTF.text forKey:@"pwd"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 200) {

            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功,快去体验立免网吧!" preferredStyle:UIAlertControllerStyleAlert];
            [self.navigationController presentViewController:alertVC animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alertVC dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [ShowMessage showMessage:result[@"message"] duration:3];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



#pragma mark - 获取验证码
-(void)fetchVerificationCodeWithURL:(NSString *)url{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.phoneNumber.text forKey:@"mobile"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([result[@"status"] intValue] == 200) {

            [ShowMessage showMessage:result[@"message"] duration:3];
        }else{
            
            [ShowMessage showMessage:result[@"message"] duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
