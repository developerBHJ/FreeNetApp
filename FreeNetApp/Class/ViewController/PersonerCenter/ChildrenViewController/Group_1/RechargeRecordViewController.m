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
@interface RechargeRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *rechargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UITextField *sumTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITableView *rechargeTableView;

@property (nonatomic,strong)NSMutableArray *paymentData;


@end

@implementation RechargeRecordViewController
#pragma mark >>>>>> 懒加载
-(NSMutableArray *)paymentData{

    if (!_paymentData) {
        _paymentData = [NSMutableArray new];
    }
    return _paymentData;
}
#pragma mark >>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"充值记录" style:UIBarButtonItemStylePlain target:self action:@selector(rechargeRecord:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];

    [self.rechargeTableView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:@"RechargeCell"];
    self.navigationItem.title = @"账户充值";
    [self setView];
    self.rechargeTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setViewWithTextField:self.sumTF imageName:@"icon_subtraction" anotherImage:@"icon_add"];
}

#pragma mark >>>>>> 自定义

-(void)setTopView{

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    [self.view addSubview:backView];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

- (IBAction)sureAction:(UIButton *)sender {
    
    
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
    rightView.size = CGSizeMake(26, 26);
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 26, 26)];
    [rightView addSubview:rightBtn];
//    [rightBtn setTitle:@"+" forState:UIControlStateNormal];
//    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [rightBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    rightView.contentMode = UIViewContentModeRedraw;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc]init];
    leftView.size = CGSizeMake(41, 26);
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [leftBtn setFrame:CGRectMake(0, 0, 26, 26)];
    [leftView addSubview:leftBtn];
//    [leftBtn setTitle:@"-" forState:UIControlStateNormal];
//    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(subtractionAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(26, 5.5, 15, 15)];
    rightImage.image = [UIImage imageNamed:@"icon_money"];
    [leftView addSubview:rightImage];
    leftBtn.contentMode = UIViewContentModeRedraw;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}


-(void)addAction:(UIButton *)sender{

    int num = 10;
    int temp = 10;
    num += temp;
    self.sumTF.text = [NSString stringWithFormat:@"%d 元",num];
}

-(void)subtractionAction:(UIButton *)sender{

    int num = 10;
    int temp = 10;
    num -= temp;
    self.sumTF.text = [NSString stringWithFormat:@"%d 元",num];
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

    return 50;
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
    [tableView reloadData];
}
@end
