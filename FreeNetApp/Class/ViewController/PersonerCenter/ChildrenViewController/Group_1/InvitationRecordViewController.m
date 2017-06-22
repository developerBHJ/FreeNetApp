//
//  InvitationRecordViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "InvitationRecordViewController.h"
#import "InvitationCell.h"
#import "InvitationModel.h"

@interface InvitationRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *invitationTableView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation InvitationRecordViewController



#pragma mark - Init
-(UITableView *)invitationTableView{

    if (!_invitationTableView) {
        _invitationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStyleGrouped];
        _invitationTableView.delegate = self;
        _invitationTableView.dataSource = self;
        _invitationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _invitationTableView;
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
    
    self.navigationItem.title = @"邀请记录";
    
    //数据请求 - 邀请记录
    [self invitationRecordWithURL:API_URL(@"/my/invites")];
    
    [self setView];

    
//    if (self.dataArray.count == 0) {
//        [self setViewWithNothingWithImageName:@"Hands" alerntTitle:@"您还没有邀请记录哦" buttonTitle:nil subContent:nil selector:nil imageFrame:CGRectMake(kScreenWidth / 2.5, kScreenHeight / 2.5, kScreenWidth / 5, kScreenWidth / 5.5)];
//    }else{
//        [self setView];
//    }
    
}



#pragma mark - Table Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvitationCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kScreenHeight / 9.3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}



#pragma mark - Custom UI
-(void)setView{

    [self.view addSubview:self.invitationTableView];
    [self.invitationTableView registerNib:[UINib nibWithNibName:@"InvitationCell" bundle:nil] forCellReuseIdentifier:@"InvitationCell"];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 43, kScreenWidth, 43)];
    backView.backgroundColor = [UIColor redColor];
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(backView.frame) - 20, 43)];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.text = @"累计已邀请100位好友，累计已获得1000欢乐豆";
    [contentLabel setFont:[UIFont systemFontOfSize:12]];
    [backView addSubview:contentLabel];
    [self.view addSubview:backView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction:)];
}

-(void)shareAction:(UIBarButtonItem *)sender{

    [[BHJTools sharedTools]showShareView];
}



#pragma mark - Data Request
    //邀请记录
-(void)invitationRecordWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"user_id"];
    [parameter setValue:@"1" forKey:@"page"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
    
        for (NSDictionary *object in result[@"data"]) {
            
            InvitationModel *model = [[InvitationModel alloc]init];
            [model setValuesForKeysWithDictionary:object];
            [self.dataArray addObject:model];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.invitationTableView reloadData];
        });
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
        
    }];
}




@end
