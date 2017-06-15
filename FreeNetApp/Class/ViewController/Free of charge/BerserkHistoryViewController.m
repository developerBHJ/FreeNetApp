//
//  BerserkHistoryViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/9.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkHistoryViewController.h"
#import "BerserkHistoryCell.h"

@interface BerserkHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *berserkHistoryView;
@property (nonatomic,strong)NSString *startTime;

@end

@implementation BerserkHistoryViewController
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
#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
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
    if (indexPath.row == 0) {
        cell.circleLabel.backgroundColor = [UIColor colorWithHexString:@"#e34a44"];
        cell.leftView.image = [UIImage imageNamed:@"berserk_back_red"];
        cell.user_name.textColor = [UIColor colorWithHexString:@"#e4504b"];
        cell.user_level.image = [UIImage imageNamed:@"star"];
        cell.markLabel.backgroundColor = [UIColor colorWithHexString:@"#e34a44"];
        cell.user_image.borderColor = [UIColor colorWithHexString:@"#e34a44"];
        cell.user_image.borderWidth = 2.5;
        cell.firstLabel.hidden = YES;
    }else{
        cell.circleLabel.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
        cell.leftView.image = [UIImage imageNamed:@"BGView_gray"];
        cell.user_name.textColor = [UIColor colorWithHexString:@"#696969"];
        cell.user_level.image = [UIImage imageNamed:@"moon"];
        cell.markLabel.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
        cell.firstLabel.hidden = NO;
    }
    if (self.historyState == HistoryViewStatusWithBerserk) {
        cell.awardLabel.hidden = NO;
        cell.winningRate.text = @"18%";
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
