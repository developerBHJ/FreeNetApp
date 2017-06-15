//
//  EvaluationViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "EvaluationViewController.h"
#import "BHJMultistageTableViewController.h"
#import "EvaluationCell.h"
#import "EvaluationHeadView.h"
#import "Model.h"
#import "HeadModel.h"
#import "EvaluationCell_0.h"
#import "EvaluationCell_1.h"
#import "EvaluationCell_2.h"
#import "EvaluationFooterView.h"

@interface EvaluationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *evaluationTableView;

@property(nonatomic,strong)NSMutableArray *myDataArr;

@end

@implementation EvaluationViewController
#pragma mark >>>>>>>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUp];
    [self initData];
}
#pragma mark >>>>>>>>>>>> 懒加载
-(UITableView *)evaluationTableView{

    if (!_evaluationTableView) {
        _evaluationTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 84, kScreenWidth - 20, kScreenHeight - 104) style:UITableViewStyleGrouped];
        _evaluationTableView.delegate = self;
        _evaluationTableView.dataSource = self;
        _evaluationTableView.cornerRadius = 5;
        _evaluationTableView.backgroundColor = [UIColor whiteColor];
    }
    return _evaluationTableView;
}

- (NSMutableArray *)myDataArr{
    if (_myDataArr == nil) {
        _myDataArr = [NSMutableArray array];
    }
    return _myDataArr;
}
#pragma mark >>>>>>>>>>>> 自定义
-(void)setUp{

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"评价晒单";
    [self.evaluationTableView registerNib:[UINib nibWithNibName:@"EvaluationCell" bundle:nil] forCellReuseIdentifier:@"EvaluationCell"];
    [self.evaluationTableView registerNib:[UINib nibWithNibName:@"EvaluationCell_0" bundle:nil] forCellReuseIdentifier:@"EvaluationCell_0"];
    [self.evaluationTableView registerNib:[UINib nibWithNibName:@"EvaluationCell_1" bundle:nil] forCellReuseIdentifier:@"EvaluationCell_1"];
    [self.evaluationTableView registerNib:[UINib nibWithNibName:@"EvaluationCell_2" bundle:nil] forCellReuseIdentifier:@"EvaluationCell_2"];
    [self.view addSubview:self.evaluationTableView];
}

-(void)initData
{
    GroupModel *group = [[GroupModel alloc]init];
    group.myTitle = @"标签";
    NSMutableArray *data =[[NSMutableArray alloc]init];
    Model *model21= [[Model alloc]init];
    model21.nameStr = @"口感不错";
    [data addObject:model21];
    Model *model22= [[Model alloc]init];
    model22.nameStr = @"价格便宜";
    [data addObject:model22];

    [group.myDataArr addObjectsFromArray:data];
    [self.myDataArr addObject:group];
}

#pragma mark >>>>>>>>>>>> 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.myDataArr.count + 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        GroupModel *groupModel = self.myDataArr[0];
        if (groupModel.isExpand == YES) {
            return groupModel.myDataArr.count;
        }else{
            return 0;
        }
    }else{
        return 2;
    }
}

//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 2) {
        return kScreenHeight / 3.3;
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kScreenHeight / 6;
        }
    }
    return kScreenHeight / 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        GroupModel *groupModel = self.myDataArr[0];
        Model *tempModel = groupModel.myDataArr[indexPath.row];
        EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationCell" forIndexPath:indexPath];
        [cell upDataWithHead:nil andTitle:tempModel.nameStr andIsselected:tempModel.isSelect];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 0){
        if (indexPath.row == 0) {
            EvaluationCell_0 *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationCell_0" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationCell" forIndexPath:indexPath];
            [cell.rightBtn removeFromSuperview];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            EvaluationCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationCell_1" forIndexPath:indexPath];
            cell.delegate = self;
            cell.index = indexPath;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            EvaluationCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationCell_2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        EvaluationHeadView *view = [EvaluationHeadView shareEvaluationHeadView];
        GroupModel *groupModel = [self.myDataArr objectAtIndex:0];
        view .myTapAction = ^(NSInteger tag)
        {
            groupModel.isExpand = !groupModel.isExpand;
            NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
            [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return view;
    }
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    EvaluationFooterView *footerView = [EvaluationFooterView shareEvaluationFooterView];
    footerView.cameraBtn.tag = 1000;
    footerView.submitBtn.tag = 1001;
    footerView.footerViewAction = ^(NSInteger tag){
        if (tag == 1000) {
            NSLog(@"%ld",(long)tag);
        }else{
            NSLog(@"%ld",(long)tag);
        }
    };
    return footerView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        NSLog(@"%ld------%ld",(long)indexPath.section,indexPath.row);
    }
}
#pragma mark >>> 
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{

    NSLog(@"保存");
}

@end
