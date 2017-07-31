//
//  OpenRiceHistoryViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "OpenRiceHistoryViewController.h"
#import "OpenRiceRecordCell.h"

#import "OpenHistoryModel.h"
@interface OpenRiceHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *recordView;
@property (nonatomic,strong)NSMutableArray *recordData;


@end

static NSString *historyUrl = @"http://192.168.0.254:4004/publics/shop_logs";

@implementation OpenRiceHistoryViewController

-(instancetype)initWithLid:(NSNumber *)lid{

    self = [super init];
    if (self) {
        self.lid = lid;
    }
    return self;
}
#pragma mark >>>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *paramater = [NSDictionary dictionaryWithObjectsAndKeys:self.lid,@"lid", nil];
    // 获取数据
    [self requestHistoryDataWithUrl:historyUrl paramater:paramater];
    
    self.navigationItem.title = @"历史记录";
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    backView.image = [UIImage imageNamed:@"bg"];
    [self.recordView registerNib:[UINib nibWithNibName:@"OpenRiceRecordCell" bundle:nil] forCellReuseIdentifier:@"OpenRiceRecordCell"];
    [self.view addSubview:backView];
    [self.view addSubview:self.recordView];
}
#pragma mark >>>>>>>> 懒加载
-(UITableView *)recordView{
    
    if (!_recordView) {
        _recordView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth / 8, 64, kScreenWidth - kScreenWidth / 4, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _recordView.backgroundColor = [UIColor clearColor];
        _recordView.showsHorizontalScrollIndicator = NO;
        _recordView.showsVerticalScrollIndicator = NO;
        _recordView.delegate = self;
        _recordView.dataSource = self;
    }
    return _recordView;
}


-(NSMutableArray *)recordData{
    
    if (!_recordData) {
        _recordData = [NSMutableArray new];
    }
    return _recordData;
}
#pragma mark >>>>>>>> 自定义

/**
 获取开饭啦历史记录
 
 @param url 历史记录数据网址
 @param paramater 参数
 */
-(void)requestHistoryDataWithUrl:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            weak.recordData = [OpenHistoryModel mj_objectArrayWithKeyValuesArray:arr];
            [weak.recordView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark >>>>>>>> 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.recordData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OpenRiceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OpenRiceRecordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.recordData[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 4.73;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 15;
    }else{
        return 2.5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 2.5;
}

@end
