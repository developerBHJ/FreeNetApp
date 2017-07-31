//
//  BHJPropertyView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/27.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "BHJPropertyView.h"
#import "RechargeCell.h"
#import "OrderAddressCell.h"
#import "OrderCell.h"

#define kCouponUrl @"http://192.168.0.254:4004/coupons/buy"
#define kSpecialUrl @"http://192.168.0.254:4004/special/shop"

@interface BHJPropertyView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *paymentData;
@property (nonatomic,strong)UIButton *sureBtn;
@property (nonatomic,strong)NSMutableDictionary *paramater;
@end

@implementation BHJPropertyView
#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(NSMutableArray *)paymentData{
    
    if (!_paymentData) {
        _paymentData = [NSMutableArray new];
    }
    return _paymentData;
}

-(NSMutableDictionary *)paramater{

    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"lid", nil];
    }
    return _paramater;
}
#pragma mark - setupUI
-(void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBtn setFrame:self.bounds];
    backBtn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
    [backBtn addTarget:self action:@selector(viewDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#e4504b"]];
    [self.sureBtn setFrame:CGRectMake(0, self.height - 40, self.width, 40)];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(confirmPayment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sureBtn];
    
    self.paymentView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height - 405, MainScreen_width, 365) style:UITableViewStyleGrouped];
    self.paymentView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.paymentView.scrollEnabled = NO;
    self.paymentView.backgroundColor = [UIColor clearColor];
    
    [self.paymentView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    [self.paymentView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:@"RechargeCell"];
    [self.paymentView registerNib:[UINib nibWithNibName:@"OrderAddressCell" bundle:nil] forCellReuseIdentifier:@"OrderAddressCell"];
    self.paymentView.delegate = self;
    self.paymentView.dataSource = self;
    [self addSubview:self.paymentView];
    
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

-(void)showPropertyView{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}


-(void)setModel:(CashCouponModel *)model{
    
    _model = model;
}

-(void)setSpecialModel:(SpecialDetailModel *)specialModel{
    
    _specialModel = specialModel;
}
#pragma mark - Method
-(void)viewDismiss{
    
    [self removeFromSuperview];
}

/**
 确认支付，接支付接口
 */
-(void)confirmPayment{
    
    if (self.model) {
        [self confirmPaymentWith:kCouponUrl paramater:self.paramater];
    }else{
        [self confirmPaymentWith:kSpecialUrl paramater:self.paramater];
    }
}


/**
 确认支付，提交订单

 @param url 确认支付URL
 @param paramater 参数
 */
-(void)confirmPaymentWith:(NSString *)url paramater:(NSDictionary *)paramater{

    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.label.text = responseObject[@"message"];
        [hud hideAnimated:YES afterDelay:3];
        [self viewDismiss];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return 3;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        OrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAddressCell" forIndexPath:indexPath];
        cell.selected = NO;
        return cell;
    }else if (indexPath.section == 0){
        OrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
        if (self.model) {
            orderCell.model = self.model;
        }else{
            orderCell.specialModel = self.specialModel;
        }
        orderCell.selected = NO;
        tableView.separatorColor = [UIColor clearColor];
        return orderCell;
    }else{
        RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeCell" forIndexPath:indexPath];
        tableView.separatorColor = [UIColor lightGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWithModel:self.paymentData[indexPath.row]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return 64;
    }else if (indexPath.section == 0){
        return 120;
    }else{
        return 60;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
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
}

@end
