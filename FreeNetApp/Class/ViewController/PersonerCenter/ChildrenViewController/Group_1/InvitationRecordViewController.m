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

@property (nonatomic,strong)UILabel *contentLabel;
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
}

#pragma mark - Table Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableView showViewWithImage:@"Hands" alerttitle:@"您还没有邀请记录哦~" buttonTitle:nil subContent:nil selectore:nil imageFrame:CGRectMake(kScreenWidth / 2.5, kScreenHeight / 2.5, kScreenWidth / 5, kScreenWidth / 5.5) byDataSourceCount:self.dataArray.count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvitationCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
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
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(backView.frame) - 20, 43)];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.text = @"累计已邀请100位好友，累计已获得1000欢乐豆";
    [self.contentLabel setFont:[UIFont systemFontOfSize:12]];
    [backView addSubview:self.contentLabel];
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
    
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            NSArray *data = responseObject[@"data"];
            if (data.count > 0) {
                weakSelf.dataArray = [InvitationModel mj_objectArrayWithKeyValuesArray:data];
                weakSelf.contentLabel.text = [NSString stringWithFormat:@"累计已邀请%lu位好友，累计已获得%ld欢乐豆",(unsigned long)data.count,100 * data.count];
                [weakSelf.invitationTableView reloadData];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}




@end
