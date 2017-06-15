//
//  ModifyPayPwdViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "ModifyPayPwdViewController.h"

#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数

@interface ModifyPayPwdViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIButton *nextBtn;
@property (nonatomic, strong) BHJTextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点

@end

@implementation ModifyPayPwdViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBaseView];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self clearUpPassword];
}
#pragma mark - 自定义
-(void)setBaseView{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 79, kScreenWidth - 20, 18)];
    titleLabel.text = @"请输入原来的立免网支付密码";
    titleLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:titleLabel];
    
    [self.view addSubview:self.textField];
    //页面出现时让键盘弹出
    [self.textField becomeFirstResponder];
    [self initPwdTextField];
    self.textField.cornerRadius = 5;
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setFrame:CGRectMake(10, self.textField.bottom + 20, kScreenWidth - 20, kScreenHeight / 11.95)];
    self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    [self.nextBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.nextBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.cornerRadius = 5;
    [self.nextBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
}



#pragma mark - 下一步
- (void)btnEvent:(UIButton *)sender {
    
    [self settingPayPasswordWithURL:@"https://api.limian.com/Auth/payPassword"];
}



- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (self.view.width - 20) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, kScreenHeight / 11.95)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
        [self.view addSubview:lineView];
    }
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (kScreenHeight / 11.95 - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.view addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  清除密码
 */
- (void)clearUpPassword
{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
    }
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[BHJTextField alloc] initWithFrame:CGRectMake(10, kScreenHeight / 4.98, kScreenWidth - 20, kScreenHeight / 11.95)];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor colorWithHexString:@"#bebebe"] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}



#pragma mark -数据请求
-(void)settingPayPasswordWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.textField.text forKey:@"payPassword"];
    NSLog(@"%@",parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@",result);
       
        if ([result[@"code"] intValue] == 200) {
            [ShowMessage showMessage:result[@"res"] duration:3];
        }else{
            [ShowMessage showMessage:result[@"res"] duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];


}



@end

@implementation BHJTextField

/**
 * /禁止可被粘贴复制
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
