//
//  PersonerFreeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerFreeViewController.h"
#import "myFreeCell.h"
#import "EvaluationViewController.h"

@interface PersonerFreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myFreeView;
@property (nonatomic,strong)NSMutableArray *myFreeData;



@end

@implementation PersonerFreeViewController
#pragma mark >>> 懒加载
-(UITableView *)myFreeView{
    
    if (!_myFreeView) {
        _myFreeView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight - 55) style:UITableViewStylePlain];
        _myFreeView.delegate = self;
        _myFreeView.dataSource = self;
    }
    return _myFreeView;
}

-(NSMutableArray *)myFreeData{
    
    if (!_myFreeData) {
        _myFreeData = [NSMutableArray new];
    }
    return _myFreeData;
}
#pragma mark >>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}

#pragma mark >>> 自定义

-(void)setView{
    
    self.navigationItem.title = @"我的免费";

    for (int i = 0; i < 10; i ++) {
        BaseModel *model = [[BaseModel alloc]init];
        [self.myFreeData addObject:model];
    }
    [self.myFreeView registerNib:[UINib nibWithNibName:@"myFreeCell" bundle:nil] forCellReuseIdentifier:@"myFreeCell"];
    [self.view addSubview:self.myFreeView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:@[@"待付款",@"待收货",@"待评价",@"已完成",@"已换货"]];
    segementView.selectedSegmentIndex = 0;
    [segementView setFrame:CGRectMake(kScreenWidth * 0.05, 10, kScreenWidth * 0.9, 35)];
    //    segementView.segmentedControlStyle = UISegmentedControlSegmentAlone;
    [segementView addTarget:self action:@selector(changeViewWithData:) forControlEvents:UIControlEventValueChanged];
    //    [segementView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [segementView setTintColor:[UIColor redColor]];
    [backView addSubview:segementView];
}


-(void)changeViewWithData:(UISegmentedControl *)sender{
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [self.myFreeData removeAllObjects];
            for (int i = 0; i < 5; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myFreeData addObject:model];
            }
        }
            break;
        case 1:
        {
            [self.myFreeData removeAllObjects];
            for (int i = 0; i < 2; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myFreeData addObject:model];
            }
        }
            break;
        case 2:
        {
            [self.myFreeData removeAllObjects];
            for (int i = 0; i < 7; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myFreeData addObject:model];
            }
        }
            break;
        case 3:
        {
            [self.myFreeData removeAllObjects];
            for (int i = 0; i < 2; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myFreeData addObject:model];
            }
        }
            break;
        case 4:
        {
            [self.myFreeData removeAllObjects];
            for (int i = 0; i < 3; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myFreeData addObject:model];
            }
        }
            break;
            
        default:
            break;
    }
    [self.myFreeView reloadData];
}

#pragma mark >>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myFreeData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 5.8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myFreeCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    cell.postageLabel.hidden = YES;
    if (indexPath.row == 0) {
        cell.postageLabel.hidden = NO;
    }else if (indexPath.row == 1){
        [cell.payBtn setTitle:@"物流跟踪" forState:UIControlStateNormal];
    }else if (indexPath.row == 2){
        [cell.payBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
    }else if (indexPath.row == 3){
        [cell.payBtn setTitle:@"交易完成" forState:UIControlStateNormal];
        [cell.payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.payBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    return cell;
}


#pragma mark >>> BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{

    if (index.row == 2) {
        EvaluationViewController *evaluationVC = [[EvaluationViewController alloc]init];
        [self.navigationController pushViewController:evaluationVC animated:YES];
    }
    NSLog(@"cellRow:----%ld",(long)index.row);
}

@end
