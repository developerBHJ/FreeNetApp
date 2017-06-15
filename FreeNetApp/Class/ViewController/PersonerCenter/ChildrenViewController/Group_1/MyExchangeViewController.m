//
//  MyExchangeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MyExchangeViewController.h"
#import "myExchangeCell.h"

@interface MyExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myExchangeView;
@property (nonatomic,strong)NSMutableArray *myExchangeData;

@end

@implementation MyExchangeViewController
#pragma mark >>> 懒加载
-(UITableView *)myExchangeView{
    
    if (!_myExchangeView) {
        _myExchangeView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight - 55) style:UITableViewStylePlain];
        _myExchangeView.delegate = self;
        _myExchangeView.dataSource = self;
    }
    return _myExchangeView;
}

-(NSMutableArray *)myExchangeData{
    
    if (!_myExchangeData) {
        _myExchangeData = [NSMutableArray new];
    }
    return _myExchangeData;
}
#pragma mark >>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}

#pragma mark >>> 自定义

-(void)setView{
    
    self.navigationItem.title = @"我的换货";
    
    for (int i = 0; i < 10; i ++) {
        BaseModel *model = [[BaseModel alloc]init];
        [self.myExchangeData addObject:model];
    }
    [self.myExchangeView registerNib:[UINib nibWithNibName:@"myExchangeCell" bundle:nil] forCellReuseIdentifier:@"myExchangeCell"];
    [self.view addSubview:self.myExchangeView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:@[@"待审核",@"已完成"]];
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
            [self.myExchangeData removeAllObjects];
            for (int i = 0; i < 5; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myExchangeData addObject:model];
            }
            
        }
            break;
        case 1:
        {
            [self.myExchangeData removeAllObjects];
            for (int i = 0; i < 2; i ++) {
                BaseModel *model = [[BaseModel alloc]init];
                [self.myExchangeData addObject:model];
            }
        }
        default:
            break;
    }
    [self.myExchangeView reloadData];
}

#pragma mark >>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myExchangeData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myExchangeCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    if (indexPath.row == 1){
        cell.markLabel.text = @"换货成功";
        cell.markLabel.backgroundColor = [UIColor redColor];
    }else if (indexPath.row == 2){
        cell.markLabel.text = @"换货审核";
        cell.markLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}


#pragma mark >>> BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    
    NSLog(@"cellRow:----%ld",(long)index.row);
}


@end
