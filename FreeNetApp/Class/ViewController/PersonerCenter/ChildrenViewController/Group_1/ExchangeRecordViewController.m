//
//  ExchangeRecordViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "ExchangeRecordViewController.h"
#import "RechargeRecordCell.h"
#import "ExchangeRecordModel.h"
@interface ExchangeRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *changeRecordView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ExchangeRecordViewController



#pragma mark - Init
-(UITableView *)changeRecordView{
    
    if (!_changeRecordView) {
        _changeRecordView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _changeRecordView.delegate = self;
        _changeRecordView.dataSource = self;
        _changeRecordView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _changeRecordView;
}

-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}




#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"兑换记录";
    
    [self.changeRecordView registerNib:[UINib nibWithNibName:@"RechargeRecordCell" bundle:nil] forCellReuseIdentifier:@"RechargeRecordCell"];
    [self.view addSubview:self.changeRecordView];
    
    //获取兑换记录
    [self fetchExchangeRecordWithURL:API_URL(@"/my/exchanges")];
}






#pragma mark - Table Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeRecordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 10;
}



#pragma mark - 获取兑换记录
-(void)fetchExchangeRecordWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [parameter setValue:@"1" forKey:@"page"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *data in result[@"data"]) {
            ExchangeRecordModel *model = [ExchangeRecordModel new];
            [model setValuesForKeysWithDictionary:data];
            [self.dataArray addObject:model];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.changeRecordView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
        
    }];



}









@end
