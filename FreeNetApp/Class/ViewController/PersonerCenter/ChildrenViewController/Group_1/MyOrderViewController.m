//
//  MyOrderViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MyOrderViewController.h"
#import "myExchangeCell.h"
#import "myIndianaCell.h"
#import "myFreeCell.h"

#import "OrderModel.h"
@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myOrderView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MyOrderViewController

#pragma mark - Init
-(UITableView *)myOrderView{
    
    if (!_myOrderView) {
        _myOrderView = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, kScreenWidth, kScreenHeight - 110) style:UITableViewStyleGrouped];
        _myOrderView.delegate = self;
        _myOrderView.dataSource = self;
    }
    return _myOrderView;
}

-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    
    //默认请求全部订单数据
    [self myOrderWithURL:@"http://192.168.0.254:1000/personer/my_orders" Type:@"5"];
    
//    if (self.dataArray.count == 0) {
//        [self setViewWithNothingWithImageName:@"order" alerntTitle:@"您还没有订单" buttonTitle:nil subContent:nil selector:nil imageFrame:CGRectMake(kScreenWidth / 2.5, kScreenHeight / 2.5, kScreenWidth / 5.5, kScreenWidth / 5)];
//    }else{
//        [self setView];
//    }
    [self setView];
}



#pragma mark - UI
-(void)setView{
    
    [self.myOrderView registerNib:[UINib nibWithNibName:@"myExchangeCell" bundle:nil] forCellReuseIdentifier:@"myExchangeCell"];
    [self.myOrderView registerNib:[UINib nibWithNibName:@"myIndianaCell" bundle:nil] forCellReuseIdentifier:@"myIndianaCell"];
    [self.myOrderView registerNib:[UINib nibWithNibName:@"myFreeCell" bundle:nil] forCellReuseIdentifier:@"myFreeCell"];
    
    [self.view addSubview:self.myOrderView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"待付款",@"待收货",@"待评价",@"已完成"]];
    segementView.selectedSegmentIndex = 0;
    [segementView setFrame:CGRectMake(kScreenWidth * 0.05, 10, kScreenWidth * 0.9, 35)];
    //    segementView.segmentedControlStyle = UISegmentedControlSegmentAlone;
    [segementView addTarget:self action:@selector(changeViewWithData:) forControlEvents:UIControlEventValueChanged];
    //    [segementView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [segementView setTintColor:[UIColor redColor]];
    [backView addSubview:segementView];
}



#pragma mark - 选择器实现
-(void)changeViewWithData:(UISegmentedControl *)sender{
    
    if (sender.selectedSegmentIndex == 0) {
        [self myOrderWithURL:@"http://192.168.0.254:1000/personer/my_orders" Type:@"5"];
    }else{
        NSString *type = [NSString stringWithFormat:@"%ld",(long)sender.selectedSegmentIndex];
        [self myOrderWithURL:@"http://192.168.0.254:1000/personer/my_orders" Type:type];
    }
}



#pragma mark - Table 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1){
        myExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myExchangeCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        
       // cell.model = self.dataArray[indexPath.row];
        
        return cell;
    }else if (indexPath.row == 0){
        myFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myFreeCell" forIndexPath:indexPath];
        
      //  cell.model = self.dataArray[indexPath.row];

        return cell;
    }else{
        myIndianaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myIndianaCell" forIndexPath:indexPath];

       // cell.model = self.dataArray[indexPath.row];

        return cell;
    }
}

#pragma mark >>> BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    
    NSLog(@"cellRow:----%ld",(long)index.row);
}



#pragma mark - 数据请求
-(void)myOrderWithURL:(NSString *)url Type:(NSString *)type{

    [self.dataArray removeAllObjects];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:type forKey:@"type"];
    [parameter setValue:user_id forKey:@"userId"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];

        for (NSDictionary *data in result) {
            OrderModel *model = [OrderModel new];
            [model setValuesForKeysWithDictionary:data];
            [self.dataArray addObject:model];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.myOrderView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
