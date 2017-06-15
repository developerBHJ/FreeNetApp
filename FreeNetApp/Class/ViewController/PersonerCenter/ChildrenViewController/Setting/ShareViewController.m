//
//  ShareViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "ShareViewController.h"
#import "shareCell.h"
@interface ShareViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *shareTableView;
@property (nonatomic,strong)NSMutableArray *shareElements;


@end

@implementation ShareViewController

#pragma mark >>>>> 懒加载
-(UITableView *)shareTableView{

    if (!_shareTableView) {
        _shareTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, kScreenHeight) style:UITableViewStyleGrouped];
        _shareTableView.delegate = self;
        _shareTableView.dataSource = self;
    }
    return _shareTableView;
}

-(NSMutableArray *)shareElements{

    if (!_shareElements) {
        _shareElements = [NSMutableArray new];
    }
    return _shareElements;
}
#pragma mark >>>>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.shareTableView];
    [self setViewWithData];
    [self.shareTableView registerNib:[UINib nibWithNibName:@"shareCell" bundle:nil] forCellReuseIdentifier:@"shareCell"];
}
#pragma mark >>>>> 自定义
-(void)setViewWithData{

    PersonerGroup *model = [[PersonerGroup alloc]initWithTitle:@"腾讯微博" image:@"tencentWeibo" subTitle:nil toViewController:nil];
    PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"人人网" image:@"renren" subTitle:nil toViewController:nil];
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"新浪微博" image:@"sinaWeibo" subTitle:nil toViewController:nil];
    [self.shareElements addObject:model];
    [self.shareElements addObject:model_1];
    [self.shareElements addObject:model_2];
}
#pragma mark >>>>> 协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [tableView showMessage:@"" byDataSourceCount:self.shareElements.count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    shareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell" forIndexPath:indexPath];
    [cell setCellWithModel:self.shareElements[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kScreenHeight / 12.08;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}



@end
