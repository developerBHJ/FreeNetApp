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
#import "OrderDetailViewController.h"

@interface PersonerFreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myFreeView;
@property (nonatomic,strong)NSMutableArray *myFreeData;
@property (nonatomic,strong)NSMutableArray *segementItems;


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

-(NSMutableArray *)segementItems{
    
    if (!_segementItems) {
        _segementItems = [NSMutableArray new];
        switch (self.viewControllerStatu) {
            case BHJViewControllerStatuFree:
            {
                [_segementItems addObjectsFromArray:@[@"待领奖",@"已领奖",@"已弃奖",@"待收货",@"待评价",@"已完成"]];
            }
                break;
            case BHJViewControllerStatuIndiana:
            {
                [_segementItems addObjectsFromArray:@[@"待付款",@"待收货",@"待评价",@"已完成"]];
            }
                break;
            case BHJViewControllerStatuSpecial:
            {
                [_segementItems addObjectsFromArray:@[@"待付款",@"待收货",@"待评价",@"已完成"]];
            }
                break;
            case BHJViewControllerStatuCoupon:
            {
                [_segementItems addObjectsFromArray:@[@"待付款",@"已付款",@"未使用",@"已使用",@"已过期"]];
            }
                break;
            case BHJViewControllerStatuOpen:
            {
                [_segementItems addObjectsFromArray:@[@"未使用",@"已使用",@"已过期"]];
            }
                break;
                
            default:
                break;
        }
    }
    return _segementItems;
}
#pragma mark >>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}
#pragma mark >>> 自定义

#pragma mark - Custon UI

-(void)setView{
    
    
    self.navigationItem.title = self.navgationTitle;
    for (int i = 0; i < self.segementItems.count; i ++) {
        OrderModel *model = [[OrderModel alloc]init];
        model.type = i;
        [self.myFreeData addObject:model];
    }
    [self.myFreeView registerNib:[UINib nibWithNibName:@"myFreeCell" bundle:nil] forCellReuseIdentifier:@"myFreeCell"];
    [self.view addSubview:self.myFreeView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:self.segementItems];
    segementView.selectedSegmentIndex = 0;
    [segementView setFrame:CGRectMake(kScreenWidth * 0.05, 10, kScreenWidth * 0.9, 35)];
    //    segementView.segmentedControlStyle = UISegmentedControlSegmentAlone;
    [segementView addTarget:self action:@selector(changeViewWithData:) forControlEvents:UIControlEventValueChanged];
    //    [segementView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [segementView setTintColor:[UIColor redColor]];
    [backView addSubview:segementView];
    [self changeViewWithData:segementView];
}


-(void)changeViewWithData:(UISegmentedControl *)sender{
    
    [self reloadDataWithIndex:sender.selectedSegmentIndex];
}

-(void)reloadDataWithIndex:(NSInteger)type{
    
    NSLog(@"=========%@",self.segementItems[type]);
    switch (self.viewControllerStatu) {
        case BHJViewControllerStatuFree:
        {
            [self.myFreeData removeAllObjects];
            OrderModel *model = [[OrderModel alloc]init];
            model.type = type;
            [self.myFreeData addObject:model];
        }
            break;
        case BHJViewControllerStatuIndiana:
        {
            [self.myFreeData removeAllObjects];
            OrderModel *model = [[OrderModel alloc]init];
            model.type = type;
            [self.myFreeData addObject:model];
        }
            break;
        case BHJViewControllerStatuSpecial:
        {
            [self.myFreeData removeAllObjects];
            OrderModel *model = [[OrderModel alloc]init];
            model.type = type;
            [self.myFreeData addObject:model];
        }
            break;
        case BHJViewControllerStatuCoupon:
        {
            [self.myFreeData removeAllObjects];
            OrderModel *model = [[OrderModel alloc]init];
            model.type = type;
            [self.myFreeData addObject:model];
        }
            break;
        case BHJViewControllerStatuOpen:
        {
            [self.myFreeData removeAllObjects];
            OrderModel *model = [[OrderModel alloc]init];
            model.type = type;
            [self.myFreeData addObject:model];
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
    OrderModel *model = self.myFreeData[indexPath.row];
    cell.model = model;
    if (self.viewControllerStatu == BHJViewControllerStatuFree) {
        if (model.type == 0) {
            cell.postageLabel.hidden = NO;
        }
    }else{
        cell.lotteryNum.hidden = YES;
        [cell.payBtn setTitle:self.segementItems[model.type] forState:UIControlStateNormal];
        if ([cell.payBtn.titleLabel.text isEqualToString:@"已完成"]) {
            [cell.payBtn setTitle:@"交易完成" forState:UIControlStateNormal];
            [cell.payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell.payBtn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]init];
    detailVC.viewControllerStatu = self.viewControllerStatu;
    detailVC.orderM = self.segementItems[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
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
