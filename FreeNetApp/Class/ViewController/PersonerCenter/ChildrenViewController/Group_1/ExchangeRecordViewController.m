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

#define kRecordUrl @"http://192.168.0.254:4004/my/exchanges"

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
        _changeRecordView.separatorColor = [UIColor clearColor];
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
    [self fetchExchangeRecordWithURL:kRecordUrl];
}






#pragma mark - Table Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableView showViewWithImage:@"exchangeRecord" alerttitle:@"您还没有兑换哦～" buttonTitle:nil subContent:nil selectore:nil imageFrame:CGRectMake(kScreenWidth / 2.75, kScreenHeight / 3, kScreenWidth / 4, kScreenWidth  / 5.5) byDataSourceCount:self.dataArray.count];
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
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSDictionary *result = responseObject[@"data"];
        if (result.count > 0) {
            weakSelf.dataArray = [ExchangeRecordModel mj_objectArrayWithKeyValuesArray:result];
            [weakSelf.changeRecordView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}









@end
