//
//  RechargeRecordViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RechargeRecordViewController.h"
#import "RechargeCell.h"
#import "RechargeViewController.h"

#define kRechargeUrl @"http://192.168.0.254:4004/publics/topup"

@interface RechargeRecordViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *rechargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UITextField *sumTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITableView *rechargeTableView;

@property (nonatomic,strong)NSMutableArray *paymentData;
@property (nonatomic,assign)NSInteger reChargeNum;
@property (nonatomic,strong)NSMutableDictionary *paramater;
@property (nonatomic,assign)NSInteger payment;

@end

@implementation RechargeRecordViewController
#pragma mark >>>>>> 懒加载
-(NSMutableArray *)paymentData{
    
    if (!_paymentData) {
        _paymentData = [NSMutableArray new];
    }
    return _paymentData;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"userId", nil];
    }
    return _paramater;
}
#pragma mark >>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.payment = -1;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"充值记录" style:UIBarButtonItemStylePlain target:self action:@selector(rechargeRecord:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
    [self.rechargeTableView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:@"RechargeCell"];
    self.navigationItem.title = @"账户充值";
    [self setView];
    self.rechargeTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setViewWithTextField:self.sumTF imageName:@"icon_subtraction" anotherImage:@"icon_add"];

    self.sumTF.delegate = self;
}

#pragma mark >>>>>> 自定义
-(void)setTopView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    [self.view addSubview:backView];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

- (IBAction)sureAction:(UIButton *)sender {
    
    if (self.payment == -1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请选择支付方式";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self.paramater setValue:@(self.payment) forKey:@"type"];
        [self.paramater setValue:@(self.reChargeNum) forKey:@"total"];
        [self rechargeWithUrl:kRechargeUrl paramater:self.paramater];
    }
    NSLog(@"确认支付");
}

-(void)rechargeRecord:(UIBarButtonItem *)sender{
    
    [self.navigationController pushViewController:[RechargeViewController new] animated:YES];
}

-(void)setView{
    
    PersonerGroup *model = [[PersonerGroup alloc]initWithTitle:@"银联支付" image:@"unionPay" subTitle:@"储蓄卡支付需开通无卡支付功能" toViewController:nil];
    model.isSelected = NO;
    PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"支付宝支付" image:@"aliPay" subTitle:@"推荐安装支付宝客户端的用户使用" toViewController:nil];
    model_1.isSelected = NO;
    
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"微信支付" image:@"weixinPay" subTitle:@"推荐安装微信5.0及以上版本的用户使用" toViewController:nil];
    model_2.isSelected = NO;
    
    [self.paymentData addObject:model_1];
    [self.paymentData addObject:model];
    [self.paymentData addObject:model_2];
}

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
    leftView.size = CGSizeMake(45, 30);
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    //    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [leftBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [leftView addSubview:leftBtn];
    //    [leftBtn setTitle:@"-" forState:UIControlStateNormal];
    //    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(subtractionAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 7.5, 15, 15)];
    rightImage.image = [UIImage imageNamed:@"icon_money"];
    [leftView addSubview:rightImage];
    leftBtn.contentMode = UIViewContentModeRedraw;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}


-(void)addAction:(UIButton *)sender{
    
    NSInteger temp = 10;
    self.reChargeNum += temp;
    self.sumTF.text = [NSString stringWithFormat:@"%ld 元",self.reChargeNum];
    self.totalPrice.text = [NSString stringWithFormat:@"%ld元",self.reChargeNum];
}

-(void)subtractionAction:(UIButton *)sender{
    
    NSInteger temp = 10;
    if (self.reChargeNum < 10) {
        self.reChargeNum = 10;
    }else{
        self.reChargeNum -= temp;
    }
    self.sumTF.text = [NSString stringWithFormat:@"%ld 元",self.reChargeNum];
    self.totalPrice.text = [NSString stringWithFormat:@"%ld元",self.reChargeNum];
}

/**
 充值
 
 @param url 充值URL
 @param paramater 参数
 */
-(void)rechargeWithUrl:(NSString *)url paramater:(NSDictionary *)paramater{
    
    NSLog(@"%@",paramater);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = responseObject[@"message"];
            [hud hideAnimated:YES afterDelay:2];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark >>>>>> 协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.paymentData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellWithModel:self.paymentData[indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i < self.paymentData.count; i ++) {
        PersonerGroup *model = self.paymentData[i];
        //        model.isSelected = !model.isSelected;
        if (i == indexPath.row) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
    }
    
    if (indexPath.row == 0) {
        self.payment = 0;
    }else if (indexPath.row == 1){
        self.payment = 2;
    }else{
        self.payment = 1;
    }
    [tableView reloadData];
}
#pragma mark - 
-(void)textFieldDidEndEditing:(UITextField *)textField{

    self.totalPrice.text = textField.text;
    self.reChargeNum = [self.totalPrice.text integerValue];
}
@end
