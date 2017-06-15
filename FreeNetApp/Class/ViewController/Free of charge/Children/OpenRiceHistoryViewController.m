//
//  OpenRiceHistoryViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "OpenRiceHistoryViewController.h"
#import "OpenRiceRecordCell.h"

@interface OpenRiceHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *recordView;
@property (nonatomic,strong)NSMutableArray *recordData;


@end

@implementation OpenRiceHistoryViewController
#pragma mark >>>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

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

#pragma mark >>>>>>>> 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    OpenRiceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OpenRiceRecordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
