//
//  ModifyPwdViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/15.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "ModifyPwdViewController.h"

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
    
        [self changePasswordWithURL:@"http://192.168.0.254:1000/center/password"];
    }
}



#pragma mark - 数据请求
-(void)changePasswordWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [parameter setValue:self.currentPwd.text forKey:@"nowpassword"];
    [parameter setValue:self.pwdTF.text forKey:@"newpassword"];
    [parameter setValue:self.confirmPwd.text forKey:@"confirmpwd"];
    NSLog(@"%@",parameter);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 0) {
            
            [ShowMessage showMessage:result[@"message"] duration:3];
                //跳转到登录页面
                //退出账号
                //移除本地数据
        }else{
            [ShowMessage showMessage:result[@"message"] duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
