//
//  OnlineServiceViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "OnlineServiceViewController.h"
#import "MoreCell.h"
@interface OnlineServiceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *customView;
@property (nonatomic,strong)NSMutableArray *customerData;
@end

@implementation OnlineServiceViewController
#pragma mark >>>> 懒加载

-(UITableView *)customView{
    
    if (!_customView) {
        _customView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _customView.delegate = self;
        _customView.dataSource = self;
        _customView.scrollEnabled = NO;
        _customView.separatorColor = HWColor(217, 216, 214, 1.0);
    }
    return _customView;
}


-(NSMutableArray *)customerData{
    
    if (!_customerData) {
        _customerData = [NSMutableArray arrayWithArray:@[@"如何选择合适的支付方式？",@"为什么支付会失败？",@"银行卡扣费成功但款项没有到账户？",@"如何保证支付安全？"]];
    }
    return _customerData;
}
#pragma mark >>>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线客服";
    [self.view addSubview:self.customView];
    [self.customView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:@"MoreCell"];
}


#pragma mark >>>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.customerData.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    cell.subTitleLabel.hidden = YES;
    cell.titleLabel.text = self.customerData[indexPath.section];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 14.6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
        
        }
            break;
            
        default:
            break;
    }
    
}

@end
