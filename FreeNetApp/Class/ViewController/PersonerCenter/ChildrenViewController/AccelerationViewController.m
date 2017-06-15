//
//  AccelerationViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AccelerationViewController.h"
#import "RechargeCell.h"

@interface AccelerationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *dropBtn;
@property (weak, nonatomic) IBOutlet UILabel *rechargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rechargeNum;
@property (weak, nonatomic) IBOutlet UILabel *rechargeMethod;
@property (weak, nonatomic) IBOutlet UITableView *rechargeTableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,strong)NSMutableArray *paymentData;




@end

@implementation AccelerationViewController
#pragma mark >>>>>> 懒加载
-(NSMutableArray *)paymentData{
    
    if (!_paymentData) {
        _paymentData = [NSMutableArray new];
    }
    return _paymentData;
}

#pragma mark >>>>>>>>>>>>>>>>>>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUp];
    
}

-(void)setUp{
    
    self.navigationItem.title = @"等级加速";
    [self.rechargeTableView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:@"RechargeCell"];
    PersonerGroup *model = [[PersonerGroup alloc]initWithTitle:@"银联支付" image:@"unionPay" subTitle:@"储蓄卡支付需开通无卡支付功能" toViewController:nil];
    PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"支付宝支付" image:@"aliPay" subTitle:@"推荐安装支付宝客户端的用户使用" toViewController:nil];
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"微信支付" image:@"weixinPay" subTitle:@"推荐安装微信5.0及以上版本的用户使用" toViewController:nil];
    [self.paymentData addObject:model];
    [self.paymentData addObject:model_1];
    [self.paymentData addObject:model_2];
    
}
#pragma mark >>>>>>>>>>>>>>>>>>>>>>> 自定义
- (IBAction)dropView:(UIButton *)sender {
    
    NSLog(@"下拉试图");
}

- (IBAction)sureAndPay:(UIButton *)sender {
    
    NSLog(@"确认支付");
}

#pragma mark >>>>>>>>>>>>>>>>>>>>>>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellWithModel:self.paymentData[indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 1;
}
@end
