//
//  AnswerViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AnswerViewController.h"
#import "answerCell.h"
#import "answerCell_1.h"
#import "AnswerModel.h"
#import "answerHeadView.h"
#import "FYCountDownView.h"
#import "answerCell_2.h"
#import "answerHeadView_1.h"
#import "answerHeadView_2.h"

#define kAnswerUrl @"http://192.168.0.254:4004/indiana/questions"
#define CommitAnswerUrl @"http://192.168.0.254:4004/indiana/useranswer"


typedef NS_ENUM(NSInteger,EnterSuccessfullyOrFailed){
    
    AnswerViewSateNomal,
    EnterSuccessfully,
    FailedToPassThrough
};

@interface AnswerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *answerView;
@property (nonatomic,strong)NSArray *answerData;
@property (strong, nonatomic)FYCountDownView *countDownView;
@property (nonatomic,strong)NSString *theme;
@property (nonatomic,strong)NSString *subTitle;
@property (nonatomic,assign)EnterSuccessfullyOrFailed answerViewState;
@property (nonatomic,strong)NSMutableDictionary *paramater;
@property (nonatomic,assign)NSInteger currentQuestion;

@end

@implementation AnswerViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.answerViewState = AnswerViewSateNomal;
    self.theme = @"第一关";
    self.subTitle = @"1/10关";
    [self setUpView];
    self.currentQuestion = 0;
    [self requestAnswerDataWithUrl:kAnswerUrl paramater:self.paramater];
}

-(void)viewWillAppear:(BOOL)animated{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    [self.view addSubview:backView];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}
#pragma mark - 懒加载
-(UITableView *)answerView{
    
    if (!_answerView) {
        _answerView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _answerView.delegate = self;
        _answerView.dataSource = self;
        _answerView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _answerView.backgroundColor = [UIColor clearColor];
    }
    return _answerView;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.model.id,@"cid", nil];
    }
    return _paramater;
}
#pragma mark - 自定义
-(void)setUpView{
    
    UIImageView *groundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -15, kScreenWidth, kScreenHeight + 15)];
    groundView.image = [UIImage imageNamed:@"answer_back"];
    [self.view addSubview:groundView];
    self.navigationItem.title = @"答题降价";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    [self.view addSubview:self.answerView];
    [self.answerView registerNib:[UINib nibWithNibName:@"answerCell" bundle:nil] forCellReuseIdentifier:@"answerCell"];
    [self.answerView registerNib:[UINib nibWithNibName:@"answerCell_1" bundle:nil] forCellReuseIdentifier:@"answerCell_1"];
    [self.answerView registerNib:[UINib nibWithNibName:@"answerCell_2" bundle:nil] forCellReuseIdentifier:@"answerCell_2"];
    
}

//  分享
-(void)share:(UIBarButtonItem *)sender{
    
    [[BHJTools sharedTools]showShareView];
}

/**
 获取题目列表
 
 @param url 题目列表URL
 @param paramater 参数
 */
-(void)requestAnswerDataWithUrl:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        weak.answerData = [AnswerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weak.answerView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 答案提交
 
 @param url 答题URL
 @param paramater 参数
 */
-(void)commitAnswerWithUrl:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        [weak loadMoreAnswerData];
        [weak.answerView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 下一题
 */
-(void)loadMoreAnswerData{
    
    if (self.currentQuestion >= 9) {
        
        // [self.countDownView stopCountDown];
        return;
    }else{
        self.currentQuestion ++;
        NSArray *titles = [NSArray arrayWithObjects:@"第一关",@"第二关",@"第三关",@"第四关",@"第五关",@"第六关",@"第七关",@"第八关",@"第九关", @"第十关",nil];
        self.theme = titles[self.currentQuestion];
        self.subTitle = [NSString stringWithFormat: @"%ld/10关",self.currentQuestion + 1];
        [self.answerView reloadData];
    }
}


/**
 cell点击事件
 
 @param cell cell
 */
-(void)cellClickEvent:(answerCell_1 *)cell{
    
    // NSIndexPath *index = [self.answerView indexPathForCell:cell];
    cell.rightImage.hidden = NO;
    BOOL status = cell.answer[@"status"];
    
    [self.paramater setObject:cell.answer[@"id"] forKey:@"aid"];
    [self.paramater setObject:@(1) forKey:@"userId"];
    [self.paramater setObject:self.model.treasure[@"price"] forKey:@"price"];
    [self commitAnswerWithUrl:CommitAnswerUrl paramater:self.paramater];
    if (status) {
        cell.contentLabel.textColor = [UIColor colorWithHexString:@"e4504b"];
        cell.rightImage.image = [UIImage imageNamed:@"answer_right"];
    }else{
        cell.contentLabel.textColor = [UIColor colorWithHexString:@"#06c1ae"];
        cell.rightImage.image = [UIImage imageNamed:@"answer_wrong"];
    }
}
#pragma mark - 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.answerViewState == AnswerViewSateNomal) {
        return 7;
    }else{
        return 3;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.answerViewState == EnterSuccessfully || self.answerViewState == FailedToPassThrough) {
        if (section == 0) {
            return 4;
        }
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.answerViewState == AnswerViewSateNomal) {
        if (indexPath.section == 0) {
            answerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell" forIndexPath:indexPath];
            cell.model = self.answerData[self.currentQuestion];
            cell.themeLabel.text = self.theme;
            cell.subTitle.text = self.subTitle;
            return cell;
        }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4){
            answerCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier:@"answerCell_1" forIndexPath:indexPath];
            AnswerModel *model = self.answerData[self.currentQuestion];
            NSArray *arr = model.answers;
            NSDictionary *dic = arr[indexPath.section - 1];
            cell_1.answer = dic;
            return cell_1;
        }else{
            answerCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier:@"answerCell_1" forIndexPath:indexPath];
            if (indexPath.section == 5) {
                [cell_1.rightImage removeFromSuperview];
                cell_1.contentLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
                cell_1.backView.backgroundColor = [UIColor colorWithHexString:@"#06c1ae"];
                cell_1.contentLabel.text = @"去掉一个错误答案消耗10欢乐豆";
            }else if (indexPath.section == 6){
                [cell_1.rightImage removeFromSuperview];
                cell_1.contentLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
                cell_1.backView.backgroundColor = [UIColor colorWithHexString:@"#9c333a"];
                cell_1.contentLabel.text = @"每过一关商品降价0.01元 每次通关商品降价0.2元";
            }
            return cell_1;
        }
    }else{
        if (indexPath.section == 0) {
            answerCell_2 *cell_2 = [tableView dequeueReusableCellWithIdentifier:@"answerCell_2" forIndexPath:indexPath];
            if (self.answerViewState == FailedToPassThrough) {
                if (indexPath.row == 0) {
                    cell_2.rightLabel.hidden = NO;
                }
            }else{
                cell_2.rightLabel.hidden = YES;
            }
            cell_2.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell_2;
        }else if(indexPath.section == 1){
            answerCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier:@"answerCell_1" forIndexPath:indexPath];
            cell_1.contentLabel.text = @"去掉一个错误答案消耗10欢乐豆";
            [cell_1.rightImage removeFromSuperview];
            cell_1.contentLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
            cell_1.backView.backgroundColor = [UIColor colorWithHexString:@"#06c1ae"];
            return cell_1;
        }else{
            answerCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier:@"answerCell_1" forIndexPath:indexPath];
            cell_1.contentLabel.text = @"每过一关商品降价0.01元 每次通关商品降价0.2元";
            [cell_1.rightImage removeFromSuperview];
            cell_1.contentLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
            cell_1.backView.backgroundColor = [UIColor colorWithHexString:@"#9c333a"];
            return cell_1;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.answerViewState == AnswerViewSateNomal) {
        if (indexPath.section == 0) {
            AnswerModel *model = self.answerData[indexPath.section];
            return model.cellHeight;
        }else if (indexPath.section == (self.answerData.count - 2) || indexPath.section == (self.answerData.count - 1)){
            return 30;
        }else {
            return 44;
        }
    }else{
        if (indexPath.section == 1 || indexPath.section == 2) {
            return 30;
        }
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.answerViewState == AnswerViewSateNomal) {
        if (section == 0) {
            return kScreenHeight / 8;
        }
        return 7;
    }else{
        if (section == 0) {
            return kScreenHeight / 5.46;
        }else if(section == 1){
            return kScreenHeight / 4;
        }else{
            return 7;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.answerViewState == AnswerViewSateNomal) {
        if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 3) {
            answerCell_1 *cell = [tableView cellForRowAtIndexPath:indexPath];
            //  [self cellClickEvent:cell];
        }
        if (indexPath.section == self
            .answerData.count - 2) {
            //  [self tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.answerViewState == AnswerViewSateNomal) {
        if (section == 0) {
            answerHeadView *headView = [answerHeadView shareanswerHeadView];
            self.countDownView = [[FYCountDownView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(headView.timerView.frame) - 20, CGRectGetHeight(headView.timerView.frame) - 20) totalTime:10 lineWidth:2 lineColor:HWColor(114, 32, 105, 1.0) startBlock:^{
            } completeBlock:^{
                // 下一题
                [self loadMoreAnswerData];
                [self.countDownView startCountDown];
            }];
            [self.countDownView startCountDown];
            headView.backgroundColor = [UIColor clearColor];
            [headView.timerView addSubview:self.countDownView];
            return headView;
        }
    }else if(self.answerViewState == EnterSuccessfully){
        if (section == 0) {
            answerHeadView_2 *headView = [answerHeadView_2 shareAnswerHeadView_2];
            headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"answer_backRed"]];
            return headView;
        }else if(section == 1){
            UIView *headView = [[UIView alloc]init];
            headView.backgroundColor = [UIColor clearColor];
            return headView;
        }
    }else{
        if (section == 0) {
            answerHeadView_1 *headView = [answerHeadView_1 shareAnswerHeadView_1];
            headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"answer_backBlack"]];
            return headView;
        }else if(section == 1){
            UIView *headView = [[UIView alloc]init];
            headView.backgroundColor = [UIColor clearColor];
            return headView;
        }
    }
    return nil;
}

@end
