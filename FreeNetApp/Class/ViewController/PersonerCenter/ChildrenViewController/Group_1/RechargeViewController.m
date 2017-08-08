//
//  RechargeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeRecordCell.h"
#import "RechargeRecordModel.h"
#define kRechargeRecordUrl @"http://192.168.0.254:4004/my/recharges"

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
    [self topUpDataWithURL:kRechargeRecordUrl];
}



#pragma mark >>>>>>>>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableView showViewWithImage:@"bil" alerttitle:@"您还没有充值哦～" buttonTitle:nil subContent:nil selectore:nil imageFrame:CGRectMake(kScreenWidth / 2.75, kScreenHeight / 3, kScreenWidth / 4, kScreenWidth  / 5.5) byDataSourceCount:self.dataArray.count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeRecordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rechargeM = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark - 充值记录 数据请求
-(void)topUpDataWithURL:(NSString *)url{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:@"1" forKey:@"userId"];
    [parameter setValue:@"1" forKey:@"page"];
    
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            NSArray *data = responseObject[@"data"];
            if (data.count > 0) {
                weakSelf.dataArray = [RechargeRecordModel mj_objectArrayWithKeyValuesArray:data];
                [weakSelf.rechargeView reloadData];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}



@end
