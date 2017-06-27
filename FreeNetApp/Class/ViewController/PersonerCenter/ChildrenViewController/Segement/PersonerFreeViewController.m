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
#import "CopounOrderCell.h"
#import "OpenOrderCell.h"

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
        _myFreeView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
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
    [self.myFreeView registerNib:[UINib nibWithNibName:@"CopounOrderCell" bundle:nil] forCellReuseIdentifier:@"CopounOrderCell"];
    [self.myFreeView registerNib:[UINib nibWithNibName:@"OpenOrderCell" bundle:nil] forCellReuseIdentifier:@"OpenOrderCell"];
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


/**
 根据不同的页面主题设置不同的cell样式

 @param cell 当前cell
 */
-(void)setCellWithType:(BaseTableViewCell *)cell{
    
    NSIndexPath *indexPath = [self.myFreeView indexPathForCell:cell];
    OrderModel *model = self.myFreeData[indexPath.row];
    myFreeCell *freeCell = (myFreeCell *)cell;
    NSString *title = self.segementItems[model.type];
    
    if ([cell isKindOfClass:[myFreeCell class]]) {
        if ([title isEqualToString:@"待评价"]) {
            [freeCell.payBtn setTitle:@"评价晒单" forState:UIControlStateNormal];
        }else if ([title isEqualToString:@"待收货"]){
            [freeCell.payBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        }else if ([title isEqualToString:@"待领奖"]){
            [freeCell.payBtn setTitle:@"去领奖" forState:UIControlStateNormal];
        }else if ([title isEqualToString:@"已领奖"] || [title isEqualToString:@"未使用"]){
            [freeCell.payBtn setTitle:@"去使用" forState:UIControlStateNormal];
        }else if ([title isEqualToString:@"待付款"]){
            [freeCell.payBtn setTitle:@"去付款" forState:UIControlStateNormal];
        }else{
            [freeCell.payBtn setTitle:title forState:UIControlStateNormal];
        }
        if (model.type == self.segementItems.count - 1) {
            [freeCell.payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [freeCell.payBtn setBackgroundColor:[UIColor lightGrayColor]];
        }else{
            [freeCell.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [freeCell.payBtn setBackgroundColor:[UIColor colorWithHexString:@"#e4504b"]];
        }
    }
    switch (self.viewControllerStatu) {
        case BHJViewControllerStatuFree:
        {
            if (model.type == 0) {
                freeCell.postageLabel.hidden = NO;
            }else{
                freeCell.postageLabel.hidden = YES;
            }
            freeCell.lotteryLabel.hidden = NO;
            freeCell.lotteryNum.hidden = NO;
        }
            break;
        case BHJViewControllerStatuIndiana:
        {
            freeCell.lotteryNum.hidden = YES;
        }
            break;
        case BHJViewControllerStatuSpecial:
        {
            freeCell.lotteryNum.hidden = YES;
        }
            break;
        case BHJViewControllerStatuCoupon:
        {
            
        }
            break;
        case BHJViewControllerStatuOpen:
        {
            CopounOrderCell *copouncell = (CopounOrderCell *)cell;
            if (model.type == 0) {
                copouncell.useBtn.hidden = NO;
                copouncell.markImage.hidden = YES;
                copouncell.selectedImage.hidden = YES;
                copouncell.backImage.image = [UIImage imageNamed:@"CopunBG_red"];
            }else if(model.type == 1){
                copouncell.useBtn.hidden = YES;
                copouncell.markImage.hidden = NO;
                copouncell.selectedImage.hidden = YES;
                copouncell.backImage.image = [UIImage imageNamed:@"CopunBG_gray"];
            }else{
                copouncell.useBtn.hidden = YES;
                copouncell.markImage.hidden = YES;
                copouncell.selectedImage.hidden = NO;
                copouncell.backImage.image = [UIImage imageNamed:@"CopunBG_gray"];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark >>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myFreeData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewControllerStatu == BHJViewControllerStatuOpen) {
        return kScreenHeight / 8.38;
    }else if (self.viewControllerStatu == BHJViewControllerStatuCoupon){
        return kScreenHeight / 4.93;
    }
    return kScreenHeight / 5.8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewControllerStatu == BHJViewControllerStatuOpen) {
        CopounOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CopounOrderCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        OrderModel *model = self.myFreeData[indexPath.row];
        cell.model = model;
        [self setCellWithType:cell];
        return cell;
    }else if (self.viewControllerStatu == BHJViewControllerStatuCoupon){
        OpenOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OpenOrderCell" forIndexPath:indexPath];
        return cell;
    }
    else{
        myFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myFreeCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        OrderModel *model = self.myFreeData[indexPath.row];
        cell.model = model;
        [self setCellWithType:cell];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]init];
    detailVC.viewControllerStatu = self.viewControllerStatu;
    detailVC.orderM = self.segementItems[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark >>> BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    [self buttonClick:button];
    switch (self.viewControllerStatu) {
        case BHJViewControllerStatuFree:
        {
            
        }
            break;
        case BHJViewControllerStatuIndiana:
        {
            
        }
            break;
        case BHJViewControllerStatuSpecial:
        {
            
        }
            break;
        case BHJViewControllerStatuCoupon:
        {
            
        }
            break;
        case BHJViewControllerStatuOpen:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)buttonClick:(UIButton *)sender{
    
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"评价晒单"]) {
        EvaluationViewController *evaluationVC = [[EvaluationViewController alloc]init];
        [self.navigationController pushViewController:evaluationVC animated:YES];
    }else if ([title isEqualToString:@"查看物流"]){
        
    }else if ([title isEqualToString:@"去领奖"]){
        
    }else if ([title isEqualToString:@"去使用"]){
        
    }else if ([title isEqualToString:@"去付款"]){
        
    }
}

@end
