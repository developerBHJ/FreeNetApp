//
//  InvitationRecordViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "InvitationRecordViewController.h"
#import "InvitationCell.h"

@interface InvitationRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *invitationTableView;
@property (nonatomic,strong)NSMutableArray *invitationRecord;

@end

@implementation InvitationRecordViewController
#pragma mark >>>>>> 懒加载
-(UITableView *)invitationTableView{

    if (!_invitationTableView) {
        _invitationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStyleGrouped];
        _invitationTableView.delegate = self;
        _invitationTableView.dataSource = self;
        _invitationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _invitationTableView;
}

-(NSMutableArray *)invitationRecord{

    if (!_invitationRecord) {
        _invitationRecord = [NSMutableArray new];
    }
    return _invitationRecord;
}
#pragma mark >>>>>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    self.navigationItem.title = @"邀请记录";
    if (self.invitationRecord.count == 0) {
        [self setViewWithNothingWithImageName:@"Hands" alerntTitle:@"您还没有邀请记录哦" buttonTitle:nil subContent:nil selector:nil imageFrame:CGRectMake(kScreenWidth / 2.5, kScreenHeight / 2.5, kScreenWidth / 5, kScreenWidth / 5.5)];
    }else{
        [self setView];
    }
}

#pragma mark >>>>>> 协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.invitationRecord.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvitationCell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kScreenHeight / 9.3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}
#pragma mark >>>>>> 自定义
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

-(void)getData{

    for (int i = 0; i < 7; i ++) {
        PersonerGroup *model = [[PersonerGroup alloc]init];
        [self.invitationRecord addObject:model];
    }
}

@end
