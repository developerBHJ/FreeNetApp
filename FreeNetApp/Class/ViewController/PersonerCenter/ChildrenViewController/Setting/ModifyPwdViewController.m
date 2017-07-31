//
//  ModifyPwdViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/15.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "LoginViewController.h"
@interface ModifyPwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *currentPwd;//旧密码
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;//确认密码
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;//新密码

@end

@implementation ModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}

#pragma mark - 自定义
-(void)setView{
    
    
}



#pragma mark -确认提交
- (IBAction)confirmAction:(UIButton *)sender {
    
    if (_pwdTF.text != _confirmPwd.text) {
        [ShowMessage showMessage:@"您输入的密码不一致" duration:3];
    }else{
        [self changePasswordWithURL:@"http://192.168.0.254:4004/users/password"];
    }
}



#pragma mark - 数据请求
-(void)changePasswordWithURL:(NSString *)url{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"user_id"];
    [parameter setValue:self.currentPwd.text forKey:@"origin"];
    [parameter setValue:self.pwdTF.text forKey:@"newpwd"];
    NSLog(@"%@",parameter);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        [ShowMessage showMessage:result[@"message"] duration:3];
        
        if ([result[@"status"] intValue] ==200) {
            //退出账号
            [self logOutWithURL:API_URL(@"/sso/users/logout")];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}

/**
 退出当前帐号
 
 @param url 网址
 */
-(void)logOutWithURL:(NSString *)url{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:@{@"user_id":user_id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([result[@"status"] intValue] == 200) {
            [ShowMessage showMessage:@"退出成功" duration:3];
            NSNotification *singOut = [[NSNotification alloc]initWithName:@"singOut" object:nil userInfo:@{@"isSuccess":@(1)}];
            [[NSNotificationCenter defaultCenter]postNotification:singOut];
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"user_login"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_token"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_mobile"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_avatar_url"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_sex"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_nickname"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_age"];
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }else{
            [ShowMessage showMessage:@"退出失败 请稍后再试" duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}

@end
