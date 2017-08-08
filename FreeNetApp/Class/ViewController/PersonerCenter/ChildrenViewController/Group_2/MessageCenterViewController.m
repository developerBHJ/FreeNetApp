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

#define kReadMessage @"http://192.168.0.254:4004/my/ready"

@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *messageView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableDictionary *paramater;

@end

@implementation MessageCenterViewController


#pragma mark - Init
-(UITableView *)messageView{
    
    if (!_messageView) {
        _messageView = [[UITableView alloc]initWithFrame:CGRectMake(0, 54, kScreenWidth, kScreenHeight - 54) style:UITableViewStylePlain];
        _messageView.delegate = self;
        _messageView.dataSource = self;
        _messageView.bounces = NO;
        _messageView.separatorColor = [UIColor clearColor];
    }
    return _messageView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"userId",@"0",@"type", nil];
    }
    return _paramater;
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";
    //构造UI
    [self setView];
}



#pragma mark - Creat UI
-(void)setView{
    
    [self.messageView registerNib:[UINib nibWithNibName:@"messageCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
    [self.view addSubview:self.messageView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 54)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"系统",@"物流"]];
    segementView.selectedSegmentIndex = 0;
    [self changeView:segementView];
    
    [segementView setFrame:CGRectMake(kScreenWidth * 0.05, 10, kScreenWidth * 0.9, 35)];
    [segementView addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    [segementView setTintColor:[UIColor colorWithHexString:@"#e4504b"]];
    [backView addSubview:segementView];
  //  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(set:)];
}

#pragma mark - 选择器方法
-(void)changeView:(UISegmentedControl *)sender{
    
    [self.paramater setValue:@(sender.selectedSegmentIndex) forKey:@"type"];
    [self fetchMessageWithURL:API_URL(@"/my/messages") paramater:self.paramater];
}



-(void)set:(UIBarButtonItem *)sender{
    
    MyMessageViewController *myMessageVC = [[MyMessageViewController alloc]init];
    myMessageVC.navgationTitle = @"我的消息";
    [self.navigationController pushViewController:myMessageVC animated:YES];
}


#pragma mark - Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableView showViewWithImage:@"Mail" alerttitle:@"您还没有消息哦～" buttonTitle:nil subContent:nil selectore:nil imageFrame:CGRectMake(kScreenWidth / 2.75, kScreenHeight / 3, kScreenWidth / 4, kScreenWidth  / 5.5) byDataSourceCount:self.dataArray.count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    messageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MessageModel *model = self.dataArray[indexPath.row];
    [self.paramater setValue:model.id forKey:@"lid"];
    [self readMessageChangStatus:kReadMessage paramater:self.paramater];
}

#pragma mark - 请求消息
-(void)fetchMessageWithURL:(NSString *)url paramater:(NSDictionary *)paramater{
    
    [self.dataArray removeAllObjects];
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            NSArray *data = responseObject[@"data"];
            if (data.count > 0) {
                weakSelf.dataArray = [MessageModel mj_objectArrayWithKeyValuesArray:data];
                [weakSelf.messageView reloadData];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}


/**
 阅读消息操作

 @param url 阅读消息改变消息状态的URL
 @param paramater 参数
 */
-(void)readMessageChangStatus:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            [weakSelf fetchMessageWithURL:API_URL(@"/my/messages") paramater:self.paramater];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}


@end
