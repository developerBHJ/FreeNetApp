//
//  ExchangeRecordViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "ExchangeRecordViewController.h"
#import "RechargeRecordCell.h"

@interface ExchangeRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *changeRecordView;
@property (nonatomic,strong)NSMutableArray *changeRecordData;


@end

@implementation ExchangeRecordViewController
#pragma mark >>>>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"兑换记录";
    [self.changeRecordView registerNib:[UINib nibWithNibName:@"RechargeRecordCell" bundle:nil] forCellReuseIdentifier:@"RechargeRecordCell"];
    [self.view addSubview:self.changeRecordView];
}

#pragma mark >>>>>>>>> 懒加载
-(NSMutableArray *)changeRecordData{
    
    if (!_changeRecordData) {
        _changeRecordData = [NSMutableArray new];
    }
    return _changeRecordData;
}

-(UITableView *)changeRecordView{
    
    if (!_changeRecordView) {
        _changeRecordView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _changeRecordView.delegate = self;
        _changeRecordView.dataSource = self;
        _changeRecordView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _changeRecordView;
}
#pragma mark >>>>>>>>> 自定义



#pragma mark >>>>>>>>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeRecordCell" forIndexPath:indexPath];

    cell.titleLabel.text = @"兑换欢乐豆";
    cell.numberLabel.text = @"1000个";
    cell.payment.text = @"¥ 10";
    cell.payment.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 10;
}


@end
