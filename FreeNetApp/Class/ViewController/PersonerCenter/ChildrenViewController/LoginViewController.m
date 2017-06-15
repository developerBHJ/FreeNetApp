//
//  LoginViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "LoginViewController.h"
#import "PersonerViewController.h"
#import "RegisterViewController.h"
#import "FindPWDViewController.h"
@interface LoginViewController ()<CAAnimationDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *regesiterBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *webChatLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *sinaLoginBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *findPWDBtn;
@property (weak, nonatomic) IBOutlet UILabel *thirdLoginLabel;
@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UITextField *user_nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIImageView *keyImage;


@end

@implementation LoginViewController
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.user_nameTF.delegate = self;

}

-(void)back:(UIBarButtonItem *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 登录
- (IBAction)loginAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:@"succeed" forKey:@"login"];
    [self.navigationController popViewControllerAnimated:YES];

    if (self.user_nameTF.text.length > 0 && self.pwdTF.text.length > 0) {
        
     //   [self loginProjectWithURL:@"http://192.168.0.254:1000/center/logins"];
    }else{
        [ShowMessage showMessage:@"用户名/密码 为空" duration:3];
    }
}



#pragma mark - 注册
- (IBAction)regesiterAction:(UIButton *)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}



#pragma mark - QQ
- (IBAction)QQLoginAction:(UIButton *)sender {
    
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}



#pragma mark - 微信
- (IBAction)WebChatLoginAction:(UIButton *)sender {
    
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}



#pragma mark - 微博
- (IBAction)SinaWeiboLoginAction:(UIButton *)sender {
    
    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
}



#pragma mark - 忘记密码
- (IBAction)findPwdAction:(UIButton *)sender {
    
    FindPWDViewController *findPwdVC = [[FindPWDViewController alloc]init];
    [self.navigationController pushViewController:findPwdVC animated:YES];
}



#pragma mark - 第三方登录
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        NSLog(@"%@",error);
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
    }];
}



#pragma mark - 登录响应事件
-(void)loginProjectWithURL:(NSString *)url{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.user_nameTF.text forKey:@"mobile"];
    [parameter setValue:self.pwdTF.text forKey:@"password"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"result = %@",result);
        
        NSDictionary *res = result[@"res"];

        if ([result[@"status"] intValue] == 200) {
            
            NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
            [userInfo setValue:@"succeed" forKey:@"login"];
            [userInfo setValue:res[@"id"] forKey:@"user_id"];//用户ID
            [userInfo setValue:res[@"mobile"] forKey:@"user_mobile"];//手机号
            [userInfo setValue:res[@"portrait"] forKey:@"user_headImage"];//头像
            [userInfo setValue:result[@"token"] forKey:@"token"];//Token

            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [ShowMessage showMessage:result[@"message"] duration:3];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
