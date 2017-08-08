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
#import "PropertyHeadView.h"
#import "PaymentCell.h"

#define kCouponUrl @"http://192.168.0.254:4004/coupons/buy"
#define kSpecialUrl @"http://192.168.0.254:4004/special/shop"
#define kIndianaUrl @"http://192.168.0.254:4004/indiana/addorder"
#define kBuyUrl @"http://192.168.0.254:4004/indiana/buygood"

@interface BHJPropertyView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *paymentData;
@property (nonatomic,strong)UIButton *sureBtn;
@property (nonatomic,strong)NSMutableDictionary *paramater;
@property (nonatomic,strong)PropertyHeadView *headView;

@end

@implementation BHJPropertyView
#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame payment:(BHJPropertyViewType)payment{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.payType = payment;
        self.backgroundColor = [UIColor clearColor];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setFrame:self.bounds];
        backBtn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
        [backBtn addTarget:self action:@selector(viewDismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#e4504b"]];
        [self.sureBtn setFrame:CGRectMake(0, self.height - 40, self.width, 40)];
        [self.sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sureBtn addTarget:self action:@selector(confirmPayment) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sureBtn];
        
        if (payment == BHJPropertyViewTypeWithCoin) {
            _paymentView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height - 284, MainScreen_width, 244) style:UITableViewStyleGrouped];
        }else{
            _paymentView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height - 404, MainScreen_width, 364) style:UITableViewStyleGrouped];
        }
        _paymentView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _paymentView.scrollEnabled = NO;
        _paymentView.backgroundColor = [UIColor clearColor];
        
        [_paymentView registerNib:[UINib nibWithNibName:@"PaymentCell" bundle:nil] forCellReuseIdentifier:@"PaymentCell"];
        [_paymentView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:@"RechargeCell"];
        [_paymentView registerNib:[UINib nibWithNibName:@"OrderAddressCell" bundle:nil] forCellReuseIdentifier:@"OrderAddressCell"];
        _paymentView.delegate = self;
        _paymentView.dataSource = self;
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
        
        [self.paymentView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [self tableView:self.paymentView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
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
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"lid",@"-1",@"payment", nil];
    }
    return _paramater;
}

-(PropertyHeadView *)headView{
    
    if (!_headView) {
        _headView = [PropertyHeadView sharePropertyHeadView];
        _headView.frame = CGRectMake(0, 0, self.width, 120);
        self.paymentView.tableHeaderView = _headView;
    }
    return _headView;
}

#pragma mark - setupUI
-(void)showPropertyView{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [keyWindow addSubview:self];
}


-(void)setModel:(CashCouponModel *)model{
    
    _model = model;
    [self.headView.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.headView.titleLabel.text = model.title;
    self.headView.subTitle.text = model.shop[@"title"];
    self.headView.priceLabel.text = model.price;
}

-(void)setSpecialModel:(SpecialDetailModel *)specialModel{
    
    _specialModel = specialModel;
    [self.headView.goodsImage sd_setImageWithURL:[NSURL URLWithString:specialModel.cover_url]];
    self.headView.titleLabel.text = specialModel.title;
    self.headView.subTitle.text = specialModel.introduction;
    self.headView.priceLabel.text = specialModel.price;
}

-(void)setIndianaModel:(IndianaDetailModel *)indianaModel{
    
    _indianaModel = indianaModel;
    NSString *imageUrl = [indianaModel.treasure[@"treasure_images"] firstObject][@"image_url"];
    [self.headView.goodsImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.headView.titleLabel.text = indianaModel.treasure[@"title"];
    self.headView.subTitle.text = indianaModel.treasure[@"introduction"];
    self.headView.priceLabel.text = indianaModel.treasure[@"price"];
}
#pragma mark - Method
-(void)viewDismiss{
    
    [self removeFromSuperview];
}

/**
 确认支付，接支付接口
 */
-(void)confirmPayment{
    
    NSInteger payment = [[self.paramater valueForKey:@"payment"] integerValue];
    if (payment == -1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.label.text = @"请选择支付方式";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self createOrder];
        switch (payment) {
            case 0:
            {
                NSLog(@"支付宝");
            }
                break;
            case 1:
            {
                NSLog(@"银联");
            }
                break;
            case 2:
            {
                NSLog(@"微信");
            }
                break;
            case 3:
            {
                NSLog(@"立免币");
            }
                break;
                
            default:
                break;
        }
    }
}

/**
 生成订单
 */
-(void)createOrder{
    
    if (self.model) {
        [self.paramater setValue:self.model.id forKey:@"lid"];
        [self confirmPaymentWith:kCouponUrl paramater:self.paramater];
    }else if (self.specialModel){
        [self.paramater setValue:self.specialModel.id forKey:@"lid"];
        [self confirmPaymentWith:kSpecialUrl paramater:self.paramater];
    }else{
        [self.paramater setValue:self.indianaModel.treasure[@"price"] forKey:@"price"];
        [self confirmPaymentWith:kIndianaUrl paramater:self.paramater];
    }
}


/**
 确认支付，提交订单
 
 @param url 确认支付URL
 @param paramater 参数
 */
-(void)confirmPaymentWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    NSLog(@"%@",paramater);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.label.text = responseObject[@"message"];
        [hud hideAnimated:YES afterDelay:3];
        
        if ([responseObject[@"status"] integerValue] == 200) {
            if (weak.indianaModel) {
                NSDictionary *dic = responseObject[@"data"];
                [weak.paramater setValue:dic[@"id"] forKey:@"lid"];
                [weak.paramater setValue:dic[@"treasure"][@"price"] forKey:@"price"];
                [weak buyGoodsWith:kBuyUrl paramater:weak.paramater];
            }
        }
        [weak viewDismiss];
    } failure:^(NSError * _Nullable error) {
        
    }];
}


/**
 夺宝岛购买商品
 
 @param url URL
 @param paramater 参数
 */
-(void)buyGoodsWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.label.text = responseObject[@"message"];
        [hud hideAnimated:YES afterDelay:3];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        if (self.payType == BHJPropertyViewTypeWithCoin) {
            return 1;
        }else{
            return 3;
        }
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        OrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAddressCell" forIndexPath:indexPath];
        cell.selected = NO;
        return cell;
    }else{
        if (self.payType == BHJPropertyViewTypeWithCoin) {
            PaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeCell" forIndexPath:indexPath];
            tableView.separatorColor = [UIColor lightGrayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setCellWithModel:self.paymentData[indexPath.row]];
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 64;
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
    
    if (indexPath.section == 1) {
        if (self.payType == BHJPropertyViewTypeWithCash) {
            for (int i = 0; i < self.paymentData.count; i ++) {
                PersonerGroup *model = self.paymentData[i];
                //        model.isSelected = !model.isSelected;
                [self.paramater setValue:@(indexPath.row) forKey:@"payment"];
                if (i == indexPath.row) {
                    model.isSelected = YES;
                }else{
                    model.isSelected = NO;
                }
            }
            [tableView reloadData];
        }else{
            [self.paramater setValue:@"3" forKey:@"payment"];
        }
    }
}

@end
