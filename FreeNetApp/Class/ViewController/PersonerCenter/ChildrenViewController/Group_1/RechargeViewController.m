//
//  RechargeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeRecordCell.h"
#import "RechargeModel.h"

@interface RechargeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *rechargeView;
@property (nonatomic,strong)NSMutableArray *rechargeRecordData;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation RechargeViewController


#pragma mark - Init
-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)rechargeView{
    
    if (!_rechargeView) {
        _rechargeView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _rechargeView.delegate = self;
        _rechargeView.dataSource = self;
        _rechargeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rechargeView;
}

-(NSMutableArray *)rechargeRecordData{
    
    if (!_rechargeRecordData) {
        _rechargeRecordData = [NSMutableArray new];
    }
    return _rechargeRecordData;
}



#pragma mark >>>>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title = @"充值记录";
    [self.rechargeView registerNib:[UINib nibWithNibName:@"RechargeRecordCell" bundle:nil] forCellReuseIdentifier:@"RechargeRecordCell"];
    [self.view addSubview:self.rechargeView];

    //数据请求 充值记录
    [self topUpDataWithURL:@"http://192.168.0.254:1000/personer/topUpRecord"];
}



#pragma mark >>>>>>>>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeRecordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kScreenHeight / 10;
}



#pragma mark - 充值记录 数据请求
-(void)topUpDataWithURL:(NSString *)url{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];

        for (NSDictionary *data in result) {
            RechargeModel *model = [RechargeModel new];
            [model setValuesForKeysWithDictionary:data];
            [self.dataArray addObject:model];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.rechargeView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView: self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
