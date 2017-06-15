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



#pragma mark - 懒加载
-(NSMutableArray *)segenmentArray{
    
    if (!_segenmentArray) {
        _segenmentArray = [NSMutableArray arrayWithArray:@[@"1 输入手机号",@"2 输入验证码",@"3 设置密码"]];
    }
    return _segenmentArray;
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}



#pragma mark - 自定义
-(void)setView{
    
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
    
    if (_phoneNumber.text.length > 0) {
        
        // 调用短信验证码接口
        [self fetchVerificationCodeWithURL:@"https://api.limian.com/Auth/sendRegisterCode"];
        
        // 用户输入的验证码数字传给server，判断请求结果作不同的逻辑处理，根据自己家的产品大大需求来即可....
        //    if (self.getVerificationBtn.isSelected) {
        [self.voditificationBtn timeFailBeginFrom:60];  // 倒计时60s
        //    }else{
        //        [self.getVerificationBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
        //    }
        
    }else{
        [ShowMessage showMessage:@"请检查您的手机号码是否正确" duration:3];
    }
}



#pragma mark - 阅读协议
- (IBAction)freeNetDelegate:(UIButton *)sender {
    
    FreeNetUserDelegateViewController *userDelegateVC = [[FreeNetUserDelegateViewController alloc]init];
    [self.navigationController pushViewController:userDelegateVC animated:YES];
}



#pragma mark - 注册
- (IBAction)nextAction:(UIButton *)sender {

    [self registActionWithURL:@"http://192.168.0.254:1000/center/register"];
}



#pragma mark - 注册响应
-(void)registActionWithURL:(NSString *)url{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.phoneNumber.text forKey:@"mobile"];
    [parameter setValue:self.voditification.text forKey:@"coding"];
    [parameter setValue:self.pwdTF.text forKey:@"password"];
    NSLog(@"%@",parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@",result);
        
        if ([result[@"status"] intValue] == 0) {

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
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([result[@"code"] intValue] == 200) {
            
            NSLog(@"获取验证码成功");
        }else{
            
            [ShowMessage showMessage:result[@"res"] duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
