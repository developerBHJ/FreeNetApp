//
//  PersonerExchangeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerExchangeViewController.h"
#import "ExchangeRecordViewController.h"
#import "PopoverView.h"

#define kChangeUrl @"http://192.168.0.254:4004/my/chargecoin"

@interface PersonerExchangeViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *exchangeStyle;
@property (weak, nonatomic) IBOutlet UITextField *styleSelected;
@property (weak, nonatomic) IBOutlet UILabel *totalprice;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel; //余额
@property (weak, nonatomic) IBOutlet UITextField *numberSelected;
@property (weak, nonatomic) IBOutlet UILabel *exchangeNum;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,assign)CGFloat exchangeNumber;


@end

@implementation PersonerExchangeViewController



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"兑换记录" style:UIBarButtonItemStylePlain target:self action:@selector(exchangeRecord:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
    self.navigationItem.title = @"兑换";
    
    [self setViewWithTextField:self.numberSelected imageName:@"icon_subtraction" anotherImage:@"icon_add"];
    // [self setViewFiled:self.styleSelected image:@"drop"];
    
    self.numberSelected.delegate = self;
    //账户余额
    [self accountBalanceWithURL:API_URL(@"/my/balance")];
    
}

#pragma mark - 确认支付
- (IBAction)sureAction:(UIButton *)sender {
    
    if (self.exchangeNumber < 1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请输入兑换欢乐豆数量";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self exchangeWithURL:kChangeUrl];
    }
}


-(void)exchangeRecord:(UIBarButtonItem *)sender{
    
    [self.navigationController pushViewController:[ExchangeRecordViewController new] animated:YES];
}

#pragma mark - 构造UI
-(void)setViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName anotherImage:(NSString *)image{
    
    UIView *rightView = [[UIView alloc]init];
    rightView.size = CGSizeMake(30, 30);
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [rightView addSubview:rightBtn];
    //    [rightBtn setTitle:@"+" forState:UIControlStateNormal];
    //    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    rightView.contentMode = UIViewContentModeRedraw;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc]init];
    leftView.size = CGSizeMake(30, 30);
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    //    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [leftBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [leftView addSubview:leftBtn];
    //    [leftBtn setTitle:@"-" forState:UIControlStateNormal];
    //    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(subtractionAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentMode = UIViewContentModeRedraw;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

-(void)setViewFiled:(UITextField *)textField image:(NSString *)imageName{
    
    UIView *rightView = [[UIView alloc]init];
    rightView.size = CGSizeMake(20, 20);
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 5, 15, 8)];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(dropDown:) forControlEvents:UIControlEventTouchUpInside];
    rightView.contentMode = UIViewContentModeRedraw;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

-(void)addAction:(UIButton *)sender{
    
    CGFloat temp = 100;
    self.exchangeNumber += temp;
    self.numberSelected.text = [NSString stringWithFormat:@"%.2f",self.exchangeNumber];
    [self.numberSelected endEditing:YES];
    self.price.text = [NSString stringWithFormat:@"%.2f立免币",self.exchangeNumber / 100];
}

-(void)subtractionAction:(UIButton *)sender{
    
    CGFloat temp = 100;
    if (self.exchangeNumber > 100) {
        self.exchangeNumber -= temp;
    }else{
        self.exchangeNumber = 100;
    }
    self.numberSelected.text = [NSString stringWithFormat:@"%.2f",self.exchangeNumber];
    self.price.text = [NSString stringWithFormat:@"%.2f立免币",self.exchangeNumber / 100];
}

-(void)dropDown:(UIButton *)sender{
    
    // 不带图片
    PopoverAction *action = [PopoverAction actionWithTitle:@"立免币" handler:^(PopoverAction *action) {
        self.styleSelected.text = action.title;
    }];
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"欢乐豆" handler:^(PopoverAction *action) {
        self.styleSelected.text = action.title;
    }];
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    [popoverView showToView:sender withActions:@[action, action1]];
}



#pragma mark - 数据请求
//兑换
-(void)exchangeWithURL:(NSString *)url{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [parameter setValue:self.numberSelected.text forKey:@"coin"];
    [parameter setValue:@(self.exchangeNumber / 100) forKey:@"gold"];
    NSLog(@"%@",parameter);
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            [weakSelf accountBalanceWithURL:API_URL(@"/my/balance")];
            NSString *result = responseObject[@"message"];
            NSLog(@"%@",result);
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//账户余额
-(void)accountBalanceWithURL:(NSString *)url{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSDictionary *result = responseObject[@"data"];
        NSString *banlance = [NSString stringWithFormat:@"余额:  %@立免币",result[@"gold"]];
        //        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:banlance];
        //        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 3)];
        self.balanceLabel.text = banlance;
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark -
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    CGFloat gold = [self.numberSelected.text floatValue] /  100;
    self.price.text = [NSString stringWithFormat:@"%.2f立免币",gold];
    self.exchangeNumber = gold;
}



@end
