//
//  MyOrderViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyCollectionCell.h"
#import "OrderModel.h"
@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myOrderView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MyOrderViewController

#pragma mark - Init
-(UITableView *)myOrderView{
    
    if (!_myOrderView) {
        _myOrderView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
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
    
    self.navigationItem.title = @"我的关注";
    
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
    
    [self.myOrderView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellReuseIdentifier:@"MyCollectionCell"];
    
    [self.view addSubview:self.myOrderView];
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
    
    return kScreenHeight / 6.35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    // cell.model = self.dataArray[indexPath.row];
    return cell;
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
