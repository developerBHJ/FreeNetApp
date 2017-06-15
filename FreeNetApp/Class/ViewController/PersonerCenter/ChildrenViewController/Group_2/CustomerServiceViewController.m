//
//  CustomerServiceViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "MoreCell.h"
#import "OnlineServiceViewController.h"

@interface CustomerServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *customView;

@end

@implementation CustomerServiceViewController
#pragma mark >>>> 懒加载

-(UITableView *)customView{

    if (!_customView) {
        _customView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _customView.delegate = self;
        _customView.dataSource = self;
        _customView.scrollEnabled = NO;
        _customView.separatorColor = HWColor(217, 216, 214, 1.0);
    }
    return _customView;
}
#pragma mark >>>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"客服中心";
    [self.view addSubview:self.customView];
    [self.customView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:@"MoreCell"];

    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    cell.titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    [cell.titleLabel setFont:[UIFont systemFontOfSize:15]];
    cell.subTitleLabel.hidden = YES;
    
    if (indexPath.section == 0) {
        cell.titleLabel.text = @"400-001-0000";
        cell.rightImage.image = [[UIImage imageNamed:@"phone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        cell.titleLabel.text = @"在线客服";
        cell.rightImage.image = [[UIImage imageNamed:@"right_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kScreenHeight / 13.2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {

        [self systemIphone];
    }else{
        OnlineServiceViewController *onlineVC = [[OnlineServiceViewController alloc]init];
        [self.navigationController pushViewController:onlineVC animated:YES];
    }
}



#pragma mark - 调用系统电话
-(void)systemIphone{

    //1.
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:@"tel:4000010000"];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
    
    //2.
    //NSString *allString = [NSString stringWithFormat:@"tel:10086"];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}








@end
