//
//  VerificationViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "VerificationViewController.h"
#import "VerificationModeViewController.h"

#import "AffirmPasswordViewController.h"//设置密码
@interface VerificationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet BHJVerifyCodeButton *sendVerificationBtn;
@property (weak, nonatomic) IBOutlet UIButton *VerificationBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherVerificationBtn;
@property (weak, nonatomic) IBOutlet UITextField *verificationTF;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end

@implementation VerificationViewController



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"安全验证";
    self.view.backgroundColor = HWColor(241, 241, 241, 1.0);
    self.phoneTF.delegate = self;
    [self.sendVerificationBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.phoneTF.text = self.iphoneNum;
}



#pragma mark - 选择验证方式
- (IBAction)moreVerifyMethod:(UIButton *)sender {
    
    VerificationModeViewController *verifyModeVC = [[VerificationModeViewController alloc]init];
    verifyModeVC.navgationTitle = @"选择验证方式";
    [self.navigationController pushViewController:verifyModeVC animated:YES];
}



#pragma mark - 验证按钮
- (IBAction)verifyAction:(UIButton *)sender {
    
    if (_phoneTF.text.length > 0 &&_verificationTF.text.length > 0) {
        
    [self verificationVerificationCodeWithURL:@"https://api.limian.com/Auth/registerValidation"];
    }else{
        [ShowMessage showMessage:@"请再检查下您所填写的内容" duration:3];
    }
}



#pragma mark - 发送验证码
- (IBAction)sendVerificationAction:(BHJVerifyCodeButton *)sender {
    
    [self codeBtnVerification];
}



#pragma mark - Block传值
-(void)strWithBlock:(ZHBlock)block{
    
    self.block = block;
}



// 获取验证码点击事件
- (void)codeBtnVerification {
    
    // 调用短信验证码接口
    [self fetchVerificationCodeWithURL:@"https://api.limian.com/Auth/sendRegisterCode"];
    
    // 用户输入的验证码数字传给server，判断请求结果作不同的逻辑处理，根据自己家的产品大大需求来即可....
    //    if (self.getVerificationBtn.isSelected) {
    [self.sendVerificationBtn timeFailBeginFrom:60];  // 倒计时60s
    //    }else{
    //        [self.getVerificationBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
    //    }
}



#pragma mark - 获取验证码
-(void)fetchVerificationCodeWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.iphoneNum forKey:@"mobile"];
    
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


#pragma mark - 验证验证码
-(void)verificationVerificationCodeWithURL:(NSString *)url{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.phoneTF.text forKey:@"mobile"];
    [parameter setValue:self.verificationTF.text forKey:@"verification"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",result);
        
        if ([result[@"code"] intValue] == 200) {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码验证成功!" preferredStyle:UIAlertControllerStyleAlert];
            [self.navigationController presentViewController:alertVC animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.block(self.verificationTF.text);
                [alertVC dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else{
            [ShowMessage showMessage:result[@"res"] duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
