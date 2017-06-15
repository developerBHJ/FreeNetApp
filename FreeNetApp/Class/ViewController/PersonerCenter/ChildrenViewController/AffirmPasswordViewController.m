//
//  AffirmPasswordViewController.m
//  FreeNetApp
//
//  Created by HanOBa on 2017/3/20.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "AffirmPasswordViewController.h"
#import "LoginViewController.h"
@interface AffirmPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码

@property (weak, nonatomic) IBOutlet UIButton *affirmButton;//确认密码

@end

@implementation AffirmPasswordViewController



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置密码";

}



#pragma mark - 确认
- (IBAction)affirmClick:(UIButton *)sender {
    
    [self affirmPasswordWithURL:@"https://api.limian.com/Auth/settingPassword"];
}




#pragma mark - 确认响应事件
-(void)affirmPasswordWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.iphoneNum forKey:@"mobile"];
    [parameter setValue:self.passwordTF.text forKey:@"password"];
    NSLog(@"%@",parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",result);
        
        if ([result[@"code"] intValue] == 200) {

            [ShowMessage showMessage:@"密码设置成功" duration:3];
        }else{
            [ShowMessage showMessage:@"密码设置失败" duration:3];
            LoginViewController *loginVC = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:loginVC animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
