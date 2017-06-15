//
//  ModifyUserNameViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/15.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "ModifyUserNameViewController.h"

@interface ModifyUserNameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextField *modifyUserName;

@end

@implementation ModifyUserNameViewController



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction:)];
    [self setRightViewWithTextField:self.modifyUserName imageName:@"close_red"];
}

/**
 *  给UITextField设置右侧的图片
 *
 *  @param textField UITextField
 *  @param imageName 图片名称
 */
-(void)setRightViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName{
    
    UIView *rightView = [[UIView alloc]init];
    rightView.size = CGSizeMake(25, 20);

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(5, 2.5, 15, 15)];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    rightView.contentMode = UIViewContentModeRedraw;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
}



#pragma mark - 确定
-(void)sureAction:(UIBarButtonItem *)sender{

    if (self.modifyUserName.text.length == 0) {
        [ShowMessage showMessage:@"用户账户昵称不能为空" duration:3];
        return;
    }
    
    [self changeUserNameWithURL:@"http://192.168.0.254:1000/center/username"];
}



#pragma mark - 清除输入框
-(void)deleteAction:(UIButton *)sender{

    self.modifyUserName.text = nil;
}



#pragma mark - 修改用户账户用户名
-(void)changeUserNameWithURL:(NSString *)url{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [parameter setValue:self.modifyUserName.text forKey:@"username"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 0) {
            [ShowMessage showMessage:result[@"message"] duration:3];
        }else{
            [ShowMessage showMessage:result[@"message"] duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}




@end
