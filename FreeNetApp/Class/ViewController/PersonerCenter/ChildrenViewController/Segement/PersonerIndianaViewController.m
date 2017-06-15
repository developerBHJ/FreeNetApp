//
//  PersonerIndianaViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerIndianaViewController.h"
#import "myIndianaCell.h"
#import "EvaluationViewController.h"

@interface PersonerIndianaViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *myIndianaView;
@property (nonatomic,strong)NSMutableArray *myIndianaData;

@end

@implementation PersonerIndianaViewController
#pragma mark >>> 懒加载
-(UITableView *)myIndianaView{
    
    if (!_myIndianaView) {
        _myIndianaView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight - 55) style:UITableViewStylePlain];
        _myIndianaView.delegate = self;
        _myIndianaView.dataSource = self;
    }
    return _myIndianaView;
}

-(NSMutableArray *)myIndianaData{
    
    if (!_myIndianaData) {
        _myIndianaData = [NSMutableArray new];
    }
    return _myIndianaData;
}
#pragma mark >>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}

#pragma mark >>> 自定义

-(void)setView{
    
    self.navigationItem.title = @"我的夺宝";
    
    for (int i = 0; i < 10; i ++) {
        BaseModel *model = [[BaseModel alloc]init];
        [self.myIndianaData addObject:model];
    }
    [self.myIndianaView registerNib:[UINib nibWithNibName:@"myIndianaCell" bundle:nil] forCellReuseIdentifier:@"myIndianaCell"];
    [self.view addSubview:self.myIndianaView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:@[@"待收货",@"带评价",@"已完成",@"已换货"]];
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
            [self.myIndianaData removeAllObjects];
            for (int i = 0; i < 5; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myIndianaData addObject:model];
            }
            
        }
            break;
        case 1:
        {
            [self.myIndianaData removeAllObjects];
            for (int i = 0; i < 2; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myIndianaData addObject:model];
            }
        }
            break;
        case 2:
        {
            [self.myIndianaData removeAllObjects];
            for (int i = 0; i < 7; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myIndianaData addObject:model];
            }
        }
            break;
        case 3:
        {
            [self.myIndianaData removeAllObjects];
            for (int i = 0; i < 2; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myIndianaData addObject:model];
            }
        }
            break;
            
        default:
            break;
    }
    [self.myIndianaView reloadData];
}

#pragma mark >>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myIndianaData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myIndianaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myIndianaCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    if (indexPath.row == 1){
        [cell.behaviorBtn setTitle:@"物流跟踪" forState:UIControlStateNormal];
    }else if (indexPath.row == 2){
        [cell.behaviorBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
    }else if (indexPath.row == 3){
        [cell.behaviorBtn setTitle:@"交易完成" forState:UIControlStateNormal];
        [cell.behaviorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.behaviorBtn setBackgroundColor:[UIColor lightGrayColor]];
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
