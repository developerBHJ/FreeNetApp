//
//  StoreListViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "StoreListViewController.h"
#import "storeListCell.h"

@interface StoreListViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewCellDelegate>

@property (nonatomic,strong)UITableView *storeListView;

@end

@implementation StoreListViewController
#pragma mark - 懒加载
-(UITableView *)storeListView{
    
    if (!_storeListView) {
        _storeListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _storeListView.delegate = self;
        _storeListView.dataSource = self;
        _storeListView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _storeListView;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
}
#pragma mark - 自定义
-(void)setUpView{

    self.navigationItem.title = @"商家列表";
    [self.view addSubview:self.storeListView];
    [self.storeListView registerNib:[UINib nibWithNibName:@"storeListCell" bundle:nil] forCellReuseIdentifier:@"storeListCell"];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 12)];
    headView.backgroundColor = HWColor(224, 218, 220, 1.0);
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, headView.height)];
    titleLabel.text = [NSString stringWithFormat:@"%ld家店通用",self.storeList.count];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    titleLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [headView addSubview:titleLabel];
    self.storeListView.tableHeaderView = headView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.storeList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    storeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storeListCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    cell.storeModel = self.storeList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 10;
}


#pragma mark - BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    FlagStoreModel *model = self.storeList[index.row];
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:@[model.tel] distance:kScreenHeight / 5];
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
        NSLog(@"%@",text);
    }];
}

@end
