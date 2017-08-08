//
//  PersonerFreeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerFreeViewController.h"
#import "myFreeCell.h"
#import "EvaluationViewController.h"
#import "OrderDetailViewController.h"
#import "CopounOrderCell.h"
#import "OpenOrderCell.h"

#import "FreeOrderModel.h"
#import "IndianaOrder.h"
#import "SpecialOrder.h"
#import "CouponOrder.h"
#import "OpenOrder.h"

#define kFreeUrl @"http://192.168.0.254:4004/my/order_frees"
#define kIndianaUrl @"http://192.168.0.254:4004/my/treasure"
#define kSpecialUrl @"http://192.168.0.254:4004/my/freeorder"
#define kCounponUrl @"http://192.168.0.254:4004/my/couponorder"
#define kOpenUrl @"http://192.168.0.254:4004/my/orderfoods"

#define kDeleteFree @"http://192.168.0.254:4004/my/free_del"
#define kDeleteIndiana @"http://192.168.0.254:4004/my/treasure_del"
#define kDeleteSpecial @"http://192.168.0.254:4004/my/product_del"
#define kDeleteCoupon @"http://192.168.0.254:4004/my/coupon_del"
#define kDeleteOpen @"http://192.168.0.254:4004/my/food_del"


@interface PersonerFreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myFreeView;
@property (nonatomic,strong)NSMutableArray *myFreeData;
@property (nonatomic,strong)NSMutableArray *segementItems;
@property (nonatomic,strong)NSMutableDictionary *paramater;
@property (nonatomic,strong)UISegmentedControl *segementView;

@end

@implementation PersonerFreeViewController
#pragma mark >>> 懒加载
-(UITableView *)myFreeView{
    
    if (!_myFreeView) {
        _myFreeView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight - 55) style:UITableViewStylePlain];
        _myFreeView.delegate = self;
        _myFreeView.dataSource = self;
        _myFreeView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
        _myFreeView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _myFreeView;
}

-(NSMutableArray *)myFreeData{
    
    if (!_myFreeData) {
        _myFreeData = [NSMutableArray new];
    }
    return _myFreeData;
}

-(NSMutableArray *)segementItems{
    
    if (!_segementItems) {
        _segementItems = [NSMutableArray new];
        switch (self.viewControllerStatu) {
            case BHJViewControllerStatuFree:
            {
                [_segementItems addObjectsFromArray:@[@"待领奖",@"已领奖",@"已弃奖",@"待收货",@"待评价",@"已完成"]];
            }
                break;
            case BHJViewControllerStatuIndiana:
            {
                [_segementItems addObjectsFromArray:@[@"待付款",@"待收货",@"待评价",@"已完成"]];
            }
                break;
            case BHJViewControllerStatuSpecial:
            {
                [_segementItems addObjectsFromArray:@[@"待付款",@"待收货",@"待评价",@"已完成"]];
            }
                break;
            case BHJViewControllerStatuCoupon:
            {
                [_segementItems addObjectsFromArray:@[@"待付款",@"已付款",@"未使用",@"已使用",@"已过期"]];
            }
                break;
            case BHJViewControllerStatuOpen:
            {
                [_segementItems addObjectsFromArray:@[@"未使用",@"已使用",@"已过期"]];
            }
                break;
                
            default:
                break;
        }
    }
    return _segementItems;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"1",@"page",@"0",@"type", nil];
    }
    return _paramater;
}
#pragma mark >>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}
#pragma mark >>> 自定义

/**
 获取订单列表
 
 @param url URL
 @param paramater 参数
 */
-(void)requestOrderListWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        NSArray *data = responseObject[@"data"];
        if (data.count > 0) {
            
            [weakSelf getOrderDataWith:data];
            [weakSelf.myFreeView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}


/**
 根据不同页面获取不同的模型数组
 
 @param data 字典数组
 */
-(void)getOrderDataWith:(NSArray *)data{
    
    switch (self.viewControllerStatu) {
        case BHJViewControllerStatuFree:
        {
            self.myFreeData = [FreeOrderModel mj_objectArrayWithKeyValuesArray:data];
        }
            break;
        case BHJViewControllerStatuIndiana:
        {
            self.myFreeData = [IndianaOrder mj_objectArrayWithKeyValuesArray:data];
        }
            break;
        case BHJViewControllerStatuSpecial:
        {
            self.myFreeData = [SpecialOrder mj_objectArrayWithKeyValuesArray:data];
        }
            break;
        case BHJViewControllerStatuCoupon:
        {
            self.myFreeData = [CouponOrder mj_objectArrayWithKeyValuesArray:data];
        }
            break;
        case BHJViewControllerStatuOpen:
        {
            self.myFreeData = [OpenOrder mj_objectArrayWithKeyValuesArray:data];
        }
            break;
        default:
            break;
    }
}

/**
 删除订单
 
 @param url URL
 @param paramater 参数
 */
-(void)deleteOrderWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            hud.label.text = responseObject[@"message"];
            [weakSelf.myFreeData removeAllObjects];
            [hud hideAnimated:YES afterDelay:1];
            [weakSelf changeViewWithData:weakSelf.segementView];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - Custon UI
-(void)setView{
    
    self.navigationItem.title = self.navgationTitle;
    
    [self.myFreeView registerNib:[UINib nibWithNibName:@"myFreeCell" bundle:nil] forCellReuseIdentifier:@"myFreeCell"];
    [self.myFreeView registerNib:[UINib nibWithNibName:@"CopounOrderCell" bundle:nil] forCellReuseIdentifier:@"CopounOrderCell"];
    [self.myFreeView registerNib:[UINib nibWithNibName:@"OpenOrderCell" bundle:nil] forCellReuseIdentifier:@"OpenOrderCell"];
    [self.view addSubview:self.myFreeView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    self.segementView = [[UISegmentedControl alloc]initWithItems:self.segementItems];
    self.segementView .selectedSegmentIndex = 0;
    [self.segementView  setFrame:CGRectMake(kScreenWidth * 0.05, 7.5, kScreenWidth * 0.9, 35)];
    //    segementView.segmentedControlStyle = UISegmentedControlSegmentAlone;
    [self.segementView  addTarget:self action:@selector(changeViewWithData:) forControlEvents:UIControlEventValueChanged];
    //    [segementView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.segementView  setTintColor:[UIColor colorWithHexString:@"#e4504b"]];
    [backView addSubview:self.segementView];
    [self changeViewWithData:self.segementView];
}


-(void)changeViewWithData:(UISegmentedControl *)sender{
    
    [self reloadDataWithIndex:sender.selectedSegmentIndex];
}

-(void)reloadDataWithIndex:(NSInteger)type{
    
    NSLog(@"=========%@",self.segementItems[type]);
    switch (self.viewControllerStatu) {
        case BHJViewControllerStatuFree:
        {
            [self.myFreeData removeAllObjects];
            [self.paramater setValue:@(type) forKey:@"type"];
            [self requestOrderListWith:kFreeUrl paramater:self.paramater];
        }
            break;
        case BHJViewControllerStatuIndiana:
        {
            [self.myFreeData removeAllObjects];
            [self.paramater setValue:@(type) forKey:@"type"];
            [self requestOrderListWith:kIndianaUrl paramater:self.paramater];
        }
            break;
        case BHJViewControllerStatuSpecial:
        {
            [self.myFreeData removeAllObjects];
            [self.paramater setValue:@(type) forKey:@"type"];
            [self requestOrderListWith:kSpecialUrl paramater:self.paramater];
        }
            break;
        case BHJViewControllerStatuCoupon:
        {
            [self.myFreeData removeAllObjects];
            [self.paramater setValue:@(type) forKey:@"type"];
            [self requestOrderListWith:kCounponUrl paramater:self.paramater];
        }
            break;
        case BHJViewControllerStatuOpen:
        {
            [self.myFreeData removeAllObjects];
            [self.paramater setValue:@(type) forKey:@"type"];
            [self requestOrderListWith:kOpenUrl paramater:self.paramater];
        }
            break;
            
        default:
            break;
    }
    [self.myFreeView reloadData];
}

#pragma mark >>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableView showMessage:@"没有订单哦，快去下单吧" byDataSourceCount:self.myFreeData.count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewControllerStatu == BHJViewControllerStatuOpen) {
        return 80;
    }else if (self.viewControllerStatu == BHJViewControllerStatuCoupon){
        return 115;
    }
    return 105;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewControllerStatu == BHJViewControllerStatuFree) {
        myFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myFreeCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FreeOrderModel *model = self.myFreeData[indexPath.row];
        cell.model = model;
        return cell;
    }else if (self.viewControllerStatu == BHJViewControllerStatuOpen){
        CopounOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CopounOrderCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OpenOrder *model = self.myFreeData[indexPath.row];
        cell.model = model;
        return cell;
    }else{
        OpenOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OpenOrderCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.viewControllerStatu == BHJViewControllerStatuIndiana) {
            IndianaOrder *indianaOrder = self.myFreeData[indexPath.row];
            cell.indianaOrder = indianaOrder;
        }else if (self.viewControllerStatu == BHJViewControllerStatuSpecial){
            SpecialOrder *specialOrder = self.myFreeData[indexPath.row];
            cell.specialOrder = specialOrder;
        }else if (self.viewControllerStatu == BHJViewControllerStatuCoupon){
            CouponOrder *couponOrder = self.myFreeData[indexPath.row];
            cell.couponOrder = couponOrder;
        }
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]init];
    detailVC.viewControllerStatu = self.viewControllerStatu;
    detailVC.orderM = self.segementItems[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return   UITableViewCellEditingStyleDelete;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        WeakSelf(weak);
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //删除关注
            GoodsModel *model = weak.myFreeData[indexPath.row];
            [weak.paramater setValue:model.id forKey:@"lid"];
            switch (weak.viewControllerStatu) {
                case BHJViewControllerStatuFree:
                    [weak deleteOrderWith:kDeleteFree paramater:weak.paramater];
                    break;
                case BHJViewControllerStatuIndiana:
                    [weak deleteOrderWith:kDeleteIndiana paramater:weak.paramater];
                    break;
                case BHJViewControllerStatuSpecial:
                    [weak deleteOrderWith:kDeleteSpecial paramater:weak.paramater];
                    break;
                case BHJViewControllerStatuCoupon:
                    [weak deleteOrderWith:kDeleteCoupon paramater:weak.paramater];
                    break;
                case BHJViewControllerStatuOpen:
                    [weak deleteOrderWith:kDeleteOpen paramater:weak.paramater];
                    break;
                default:
                    break;
            }
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark >>> BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    [self buttonClick:button];
    switch (self.viewControllerStatu) {
        case BHJViewControllerStatuFree:
        {
            
        }
            break;
        case BHJViewControllerStatuIndiana:
        {
            
        }
            break;
        case BHJViewControllerStatuSpecial:
        {
            
        }
            break;
        case BHJViewControllerStatuCoupon:
        {
            
        }
            break;
        case BHJViewControllerStatuOpen:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)buttonClick:(UIButton *)sender{
    
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"评价晒单"]) {
        EvaluationViewController *evaluationVC = [[EvaluationViewController alloc]init];
        [self.navigationController pushViewController:evaluationVC animated:YES];
    }else if ([title isEqualToString:@"查看物流"]){
        
    }else if ([title isEqualToString:@"去领奖"]){
        
    }else if ([title isEqualToString:@"去使用"]){
        
    }else if ([title isEqualToString:@"去付款"]){
        
    }
}

@end
