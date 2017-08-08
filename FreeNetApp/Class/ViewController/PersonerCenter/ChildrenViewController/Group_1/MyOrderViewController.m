//
//  MyOrderViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyCollectionCell.h"
#import "AttentionModel.h"
#import "FlagshipViewController.h"
@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myOrderView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MyOrderViewController



#pragma mark - Init
-(UITableView *)myOrderView{
    
    if (!_myOrderView) {
        _myOrderView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _myOrderView.delegate = self;
        _myOrderView.dataSource = self;
        _myOrderView.tableFooterView = [UIView new];
    }
    return _myOrderView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    //Table
    [self.myOrderView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellReuseIdentifier:@"MyCollectionCell"];
    [self.view addSubview:self.myOrderView];
    
    
    //默认请求全部关注数据
    [self myAttentionWithURL:API_URL(@"/my/focuses")];
    
}

#pragma mark - Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableView showMessage:@"您还没有关注店铺哦" byDataSourceCount:self.dataArray.count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}
//删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return   UITableViewCellEditingStyleDelete;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            //删除关注
            AttentionModel *model = self.dataArray[indexPath.row];
            [self myAttentionDeleteWithURL:API_URL(@"/my/focuseDel") Lid:model.id];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FlagshipViewController *flagVC = [[FlagshipViewController alloc]init];
    AttentionModel *model = self.dataArray[indexPath.row];
    flagVC.cid = model.shop[@"id"];
    [self.navigationController pushViewController:flagVC animated:YES];
}

#pragma mark - BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    NSLog(@"cellRow:----%ld",(long)index.row);
}



#pragma mark - 数据请求
//关注请求
-(void)myAttentionWithURL:(NSString *)url{
    
    WeakSelf(weakSelf);
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *data = responseObject[@"data"];
        if (data.count > 0) {
            weakSelf.dataArray = [AttentionModel mj_objectArrayWithKeyValuesArray:data];
            [weakSelf.myOrderView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//关注删除
-(void)myAttentionDeleteWithURL:(NSString *)url Lid:(NSNumber *)lid{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:lid forKey:@"lid"];
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            hud.label.text = responseObject[@"message"];
            [weakSelf.dataArray removeAllObjects];
            [weakSelf myAttentionWithURL:API_URL(@"/my/focuses")];
            [hud hideAnimated:YES afterDelay:2];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}




@end
