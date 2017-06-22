//
//  MessageCenterViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "messageCell.h"
#import "MyMessageViewController.h"

#import "MessageModel.h"
@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *messageView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MessageCenterViewController



#pragma mark - Init
-(UITableView *)messageView{
    
    if (!_messageView) {
        _messageView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight - 55) style:UITableViewStylePlain];
        _messageView.delegate = self;
        _messageView.dataSource = self;
        _messageView.bounces = NO;
        _messageView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _messageView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";

    //构造UI
    [self setView];
    
    //数据请求
    [self fetchMessageWithURL:API_URL(@"/my/messages") Type:0];
}



#pragma mark - Creat UI
-(void)setView{
    
    [self.messageView registerNib:[UINib nibWithNibName:@"messageCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
    [self.view addSubview:self.messageView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"系统",@"物流"]];
    segementView.selectedSegmentIndex = 0;
    [segementView setFrame:CGRectMake(kScreenWidth * 0.05, 10, kScreenWidth * 0.9, 35)];
    [segementView addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    [segementView setTintColor:[UIColor redColor]];
    [backView addSubview:segementView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(set:)];
}




#pragma mark - 选择器方法
-(void)changeView:(UISegmentedControl *)sender{
    
    [self fetchMessageWithURL:API_URL(@"/my/messages") Type:sender.selectedSegmentIndex];
}



-(void)set:(UIBarButtonItem *)sender{

    MyMessageViewController *myMessageVC = [[MyMessageViewController alloc]init];
    myMessageVC.navgationTitle = @"我的消息";
    [self.navigationController pushViewController:myMessageVC animated:YES];
}


#pragma mark - Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 6.5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    messageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    if (indexPath.row == 0) {
        cell.titleLabel.backgroundColor = [UIColor redColor];
        cell.markLabel.backgroundColor = [UIColor redColor];
        cell.titleLabel.textColor = [UIColor whiteColor];
    }else{
        cell.titleLabel.backgroundColor = [UIColor lightGrayColor];
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.markLabel.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}



#pragma mark - 请求消息
-(void)fetchMessageWithURL:(NSString *)url Type:(NSInteger)type{

    [self.dataArray removeAllObjects];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [parameter setValue:@(type) forKey:@"type"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *data in result[@"data"]) {
            MessageModel *model = [MessageModel new];
            [model setValuesForKeysWithDictionary:data];
            [self.dataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.messageView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
