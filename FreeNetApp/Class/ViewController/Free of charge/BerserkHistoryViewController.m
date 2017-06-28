//
//  BerserkHistoryViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/9.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkHistoryViewController.h"
#import "BerserkHistoryCell.h"
#import "HistoryModel.h"

#define kBerserkHistoryUrl @"http://192.168.0.254:4004/free/freelogs"

@interface BerserkHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *berserkHistoryView;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSMutableArray *historyData;
@property (nonatomic,assign)int lid;//列表id


@end

@implementation BerserkHistoryViewController

-(id)initWithID:(int)lid{
    
    self = [super init];
    if (self) {
        self.lid = lid;
    }
    return self;
}

#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setTitle:@"" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(viewDismiss:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:backBtn];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.view addSubview:self.berserkHistoryView];
    [self.berserkHistoryView registerNib:[UINib nibWithNibName:@"BerserkHistoryCell" bundle:nil] forCellReuseIdentifier:@"BerserkHistoryCell"];
    [self getCurrentTime];
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
    // 疯抢记录数据
    [self getHistoryDataWithUrl:kBerserkHistoryUrl];
}
#pragma mark -- 自定义
-(NSString *)getCurrentTime
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    self.startTime = dateTime;
    return self.startTime;
}

-(void)viewDismiss:(UIButton *)sender{
    
    self.view.hidden = YES;
}


-(void)getHistoryDataWithUrl:(NSString *)url{
    
    NSDictionary *paramater = [NSDictionary dictionaryWithObjectsAndKeys:@(self.lid),@"lid", nil];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        NSArray *history = responseObject[@"data"];
        if (history.count > 0) {
            for (NSDictionary *user in history) {
                HistoryModel *model = [HistoryModel mj_objectWithKeyValues:user];
                [self.historyData addObject:model];
            }
        }
        [self.berserkHistoryView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark -- 懒加载
-(UITableView *)berserkHistoryView{
    
    if (!_berserkHistoryView) {
        _berserkHistoryView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 50, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _berserkHistoryView.delegate = self;
        _berserkHistoryView.dataSource = self;
        _berserkHistoryView.backgroundColor = [UIColor whiteColor];
        _berserkHistoryView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _berserkHistoryView;
}

-(NSMutableArray *)historyData{
    
    if (!_historyData) {
        _historyData = [NSMutableArray new];
    }
    return _historyData;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.historyData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BerserkHistoryCell *cell = [BerserkHistoryCell initWithTableView:tableView];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [formatter dateFromString:self.startTime];
    NSDate *date2 = [NSDate date];
    NSTimeInterval aTimer = [date2 timeIntervalSinceDate:date1];
    
    int hour = (int)(aTimer/3600);
    int minute = (int)(aTimer - hour*3600)/60;
    int second = aTimer - hour*3600 - minute*60;
    NSString *dural = [NSString stringWithFormat:@"%d秒前",second];
    cell.timeLabel.text = dural;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 疯抢记录数据
    cell.model = self.historyData[indexPath.row];
    
    if (self.historyState == HistoryViewStatusWithBerserk) {
        cell.awardLabel.hidden = NO;
    }else{
        cell.awardLabel.hidden = YES;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"出价5次"];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#e4504b"] range:NSMakeRange(2, 1)];
        cell.winningRate.attributedText = attStr;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

@end
