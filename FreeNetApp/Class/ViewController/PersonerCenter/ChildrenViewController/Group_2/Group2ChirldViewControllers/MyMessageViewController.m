//
//  MyMessageViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MoreCell_1.h"
@interface MyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *messageView;


@end

@implementation MyMessageViewController
#pragma mark >>> 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.messageView];
    [self.messageView registerNib:[UINib nibWithNibName:@"MoreCell_1" bundle:nil] forCellReuseIdentifier:@"MoreCell_1"];

}


#pragma mark >>> 懒加载
-(UITableView *)messageView{
    
    if (!_messageView) {
        _messageView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _messageView.delegate = self;
        _messageView.dataSource = self;
        _messageView.scrollEnabled = NO;
    }
    return _messageView;
}

#pragma mark >>> UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 13.2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell_1" forIndexPath:indexPath];
    cell.delegate = self;
    cell.titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    [cell.titleLabel setFont:[UIFont systemFontOfSize:15]];
    switch (indexPath.row) {
        case 0:
        {
        cell.titleLabel.text = @"系统消息";
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"物流跟踪";
 
        }
            break;
            
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}
#pragma mark >>> BaseTableViewCellDelegate

-(void)BaseCellMethodWithViewController:(UIViewController *)viewController switch:(UISwitch *)sender cellRow:(NSIndexPath *)cellRow{


}

@end
