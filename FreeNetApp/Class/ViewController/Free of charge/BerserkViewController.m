//
//  BerserkViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkViewController.h"
#import "BerserkeCell_0.h"
#import "BerserkCell.h"
#import "BerserkCell_1.h"
#import "BerserkCell_2.h"
#import "BerserkHeadView.h"
#import "BerserkCell_3.h"
#import "BerserkCell_4.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "BerserkHistoryViewController.h"
#import "JXButton.h"
#import "FlagshipViewController.h"

#define DURATION 0.3f

#define HotDetail @"http://192.168.0.254:4004/free/details"

@interface BerserkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)HotRecommend *detailModel;
@property (nonatomic,strong)UITableView *BerserkView;
@property (nonatomic,strong)NSMutableArray *BerserkData;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)JXButton *selectBtn;
@property (nonatomic,assign)BOOL isClick;
@property (nonatomic,strong)BerserkHistoryViewController *historyVC;
@property (nonatomic,strong)NSTimer *myTimer;
@property (nonatomic,strong)MDRadialProgressView *progressView;
@property (nonatomic,assign)NSInteger totalTime;
@property (nonatomic,strong)MDRadialProgressTheme *theme;
@property (nonatomic,strong)NSMutableDictionary *parameter;


@end

@implementation BerserkViewController
#pragma mark - 懒加载
-(UITableView *)BerserkView{
    
    if (!_BerserkView) {
        _BerserkView = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth - 20, kScreenHeight - 108) style:UITableViewStyleGrouped];
        _BerserkView.delegate = self;
        _BerserkView.dataSource = self;
        self.view.backgroundColor = HWColor(239, 239, 239, 1.0);
    }
    return _BerserkView;
}

-(NSMutableArray *)BerserkData{
    
    if (!_BerserkData) {
        _BerserkData = [NSMutableArray new];
    }
    return _BerserkData;
}

-(NSMutableArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(self.model.id),@"lid", nil];
    }
    return _parameter;
}
#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    
    [self setUpView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageState = PageStatueWithNomal;
    self.totalTime = 90;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.bottomView removeFromSuperview];
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

-(void)dealloc{
    
    [self.myTimer invalidate];
    self.myTimer = nil;
}
#pragma mark - 自定义
-(void)setUpView{
    
    // 获取详情数据
    [self getFreeDetailDataWithUrl:HotDetail parameter:self.parameter];
    
    self.navigationItem.title = @"疯抢90秒";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithTitle:@"游戏规则" style:UIBarButtonItemStylePlain target:self action:@selector(gameRule:)];
    [right1 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[right,right1];
    
    [self.BerserkView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.BerserkView registerNib:[UINib nibWithNibName:@"BerserkeCell_0" bundle:nil] forCellReuseIdentifier:@"BerserkeCell_0"];
    [self.BerserkView registerNib:[UINib nibWithNibName:@"BerserkCell" bundle:nil] forCellReuseIdentifier:@"BerserkCell"];
    [self.BerserkView registerNib:[UINib nibWithNibName:@"BerserkCell_1" bundle:nil] forCellReuseIdentifier:@"BerserkCell_1"];
    [self.BerserkView registerNib:[UINib nibWithNibName:@"BerserkCell_2" bundle:nil] forCellReuseIdentifier:@"BerserkCell_2"];
    [self.BerserkView registerNib:[UINib nibWithNibName:@"BerserkCell_3" bundle:nil] forCellReuseIdentifier:@"BerserkCell_3"];
    [self.BerserkView registerNib:[UINib nibWithNibName:@"BerserkCell_4" bundle:nil] forCellReuseIdentifier:@"BerserkCell_4"];
    
    [self setBottomView];
    [self.view addSubview:self.BerserkView];
    
}

-(void)timerEvent{
    
    self.totalTime --;
    if (self.totalTime > 0) {
        self.progressView.progressCounter ++;
        self.progressView.label.text = [NSString stringWithFormat:@"%lu",self.progressView.progressTotal - self.progressView.progressCounter];
        [self.progressView.label setFont:[UIFont systemFontOfSize:15]];
        self.progressView.label.textColor = [UIColor colorWithHexString:@"#e4504b"];
    }else{
        [self.progressView.label setFont:[UIFont systemFontOfSize:12]];
        self.progressView.progressTotal = 1;
        self.progressView.progressCounter = 1;
        self.progressView.label.text = @"已结束";
        self.progressView.label.textColor = [UIColor colorWithHexString:@"#bebebe"];
        self.theme.completedColor = [UIColor colorWithHexString:@"#bebebe"];
        self.pageState = PageStatueWithWinning;
        UIButton *thirdBtn = [self.bottomView viewWithTag:503];
        UIButton *fifthBtn = [self.bottomView viewWithTag:502];
        thirdBtn.enabled = NO;
        fifthBtn.enabled = NO;
        self.progressView.userInteractionEnabled = NO;
        [self.BerserkView reloadData];
    }
}



-(void)setBottomView{
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
    self.bottomView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 30, - 20, 60, 60)];
    centerView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    centerView.cornerRadius = 30;
    [self.bottomView addSubview:centerView];
    
    CALayer *testLayer = [CALayer layer];
    testLayer.backgroundColor = [UIColor clearColor].CGColor;
    testLayer.frame = CGRectMake(kScreenWidth / 2 - 30, -20, 60, 60);
    [self.bottomView.layer addSublayer:testLayer];
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    solidLine.fillColor = [UIColor clearColor].CGColor;
    solidLine.strokeColor = [UIColor colorWithHexString:@"cdcdcd"].CGColor;
    solidLine.lineCap = kCALineCapRound;
    solidLine.lineWidth = 1;
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:29 startAngle:M_PI * 1.11 endAngle:M_PI * 1.89 clockwise:YES];
    solidLine.path = thePath.CGPath;
    [testLayer addSublayer:solidLine];
    
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[[UIColor colorWithHexString:@"cdcdcd"] CGColor]];
    solidShapeLayer.lineWidth = 1.0f ;
    CGPathMoveToPoint(solidShapePath, NULL, 0, 0);
    CGPathAddLineToPoint(solidShapePath, NULL, centerView.left + 2,0);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.bottomView.layer addSublayer:solidShapeLayer];
    
    CAShapeLayer *solidShapeLayer_1 = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath_1 =  CGPathCreateMutable();
    [solidShapeLayer_1 setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer_1 setStrokeColor:[[UIColor colorWithHexString:@"cdcdcd"] CGColor]];
    solidShapeLayer_1.lineWidth = 1.0f ;
    CGPathMoveToPoint(solidShapePath_1, NULL, centerView.right - 2, 0);
    CGPathAddLineToPoint(solidShapePath_1, NULL, MainScreen_width,0);
    [solidShapeLayer_1 setPath:solidShapePath_1];
    CGPathRelease(solidShapePath_1);
    [self.bottomView.layer addSublayer:solidShapeLayer_1];
    
    self.theme = [[MDRadialProgressTheme alloc] init];
    self.theme.incompletedColor = [UIColor colorWithRed:164/255.0 green:231/255.0 blue:134/255.0 alpha:1.0];
    self.theme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
    self.theme.sliceDividerHidden = YES;
    self.theme.labelColor = [UIColor colorWithHexString:@"#696969"];
    self.theme.labelShadowColor = [UIColor whiteColor];
    self.progressView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(5, 5, 50, 50) andTheme:self.theme];
    self.progressView.progressTotal = 10000;
    self.progressView.progressCounter = 1;
    self.progressView.label.text = @"未开始";
    [self.progressView.label setFont:[UIFont systemFontOfSize:12]];
    self.progressView.label.textColor = [UIColor greenColor];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerBtnClick:)];
    [self.progressView addGestureRecognizer:tapGR];
    [centerView addSubview:self.progressView];
    
    CGFloat btnWidth = (kScreenWidth - CGRectGetWidth(centerView.frame)) / 5;
    CGFloat btnHeight = CGRectGetHeight(self.bottomView.frame);
    JXButton *historyButton = [[BHJTools sharedTools]creatButtonWithTitle:@"疯抢记录" image:@"berserk_1_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(10, 5, btnWidth, btnHeight - 8) viewController:self selectedImage:@"berserk_1_selected" tag:500];
    [self.bottomView addSubview:historyButton];
    JXButton *secondButton = [[BHJTools sharedTools]creatButtonWithTitle:@"增加机会" image:@"berserk_2_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(CGRectGetMaxX(historyButton.frame) + 10, 5, btnWidth, btnHeight - 8) viewController:self selectedImage:@"berserk_2_selected" tag:501];
    [self.bottomView addSubview:secondButton];
    JXButton *thirdButton = [[BHJTools sharedTools]creatButtonWithTitle:@"直达50秒" image:@"berserk_3_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(kScreenWidth - btnWidth - 10, 5, btnWidth, btnHeight - 8) viewController:self selectedImage:@"berserk_3_selected" tag:502];
    thirdButton.enabled = NO;
    [self.bottomView addSubview:thirdButton];
    JXButton *fourthButton = [[BHJTools sharedTools]creatButtonWithTitle:@"直达30秒" image:@"berserk_4_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(CGRectGetMaxX(centerView.frame) + 10, 5, btnWidth, btnHeight - 8) viewController:self selectedImage:@"berserk_4_selected" tag:503];
    fourthButton.enabled = NO;
    [self.bottomView addSubview:fourthButton];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
}

//  底部按钮回调方法
-(void)bottomEvent:(JXButton *)sender{
    
    [self setSelectedButton:sender];
    switch (sender.tag) {
        case 500:{
            if (!self.isClick) {
                [self showHistoryView];
            }else{
                [self hiddenHistoryView];
            }
        }
            break;
        case 501:{
            if (self.isClick) {
                // [self hiddenHistoryView];
                self.isClick = NO;
            }
            NSLog(@"增加机会");
        }
            break;
        case 503:{
            // [self hiddenHistoryView];
            self.isClick = NO;
            [self.myTimer setFireDate:[NSDate distantFuture]];
            self.progressView.progressTotal = 90;
            self.progressView.progressCounter = 60;
            self.totalTime = 30;
            [self.myTimer setFireDate:[NSDate distantPast]];
            NSLog(@"直达30秒");
        }
            break;
        case 502:{
            // [self hiddenHistoryView];
            self.isClick = NO;
            [self.myTimer setFireDate:[NSDate distantFuture]];
            self.progressView.progressTotal = 90;
            self.progressView.progressCounter = 40;
            self.totalTime = 50;
            [self.myTimer setFireDate:[NSDate distantPast]];
            NSLog(@"直达50秒");
        }
            break;
            
        default:
            break;
    }
}

-(void)setSelectedButton:(JXButton *)sender{
    
    if (sender.selected) {
        sender.selected = NO;
        self.selectBtn.selected = YES;
    }else{
        self.selectBtn.selected = NO;
        sender.selected = YES;
    }
    sender.enabled = NO;
    self.selectBtn.enabled = YES;
    self.selectBtn = sender;
}

// 分享
-(void)share:(UIBarButtonItem *)sender{
    
    [[BHJTools sharedTools]showShareView];
}

// 游戏规则
-(void)gameRule:(UIBarButtonItem *)sender{
    
    NSLog(@"游戏规则");
}

-(void)centerBtnClick:(UITapGestureRecognizer *)sender{
    
    UIButton *thirdBtn = [self.bottomView viewWithTag:503];
    UIButton *fifthBtn = [self.bottomView viewWithTag:502];
    if ([self.progressView.label.text isEqualToString:@"未开始"]) {
        sender.enabled = YES;
        thirdBtn.enabled = YES;
        fifthBtn.enabled = YES;
        self.pageState = PageStatueWithLead;
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
        self.progressView.progressTotal = 90;
        self.theme.completedColor = [UIColor colorWithHexString:@"#e4504b"];
        self.theme.incompletedColor = [UIColor colorWithHexString:@"#bebebe"];
        [self.myTimer setFireDate:[NSDate distantPast]];
        [self.BerserkView reloadData];
    }else{
        sender.enabled = NO;
        thirdBtn.enabled = NO;
        fifthBtn.enabled = NO;
        [self.myTimer setFireDate:[NSDate distantFuture]];
    }
}


-(void)showHistoryView{
    
    [UIView animateWithDuration:0 animations:^{
        [self transitionWithType:kCATransitionMoveIn WithSubtype:kCATransitionFromLeft ForView:self.historyVC.view];
        self.historyVC.view.hidden = NO;
    } completion:^(BOOL finished) {
        self.historyVC.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
        self.navigationItem.title = @"疯抢记录";
    }];
    self.isClick = YES;
}


-(void)hiddenHistoryView{
    
    [UIView animateWithDuration:0 animations:^{
        [self transitionWithType:kCATransitionMoveIn WithSubtype:kCATransitionFromRight ForView:self.view];
        self.historyVC.view.hidden = YES;
    } completion:^(BOOL finished) {
        self.navigationItem.title = @"疯抢90秒";
    }];
    self.isClick = NO;
}

#pragma mark - 请求网络数据
-(void)getFreeDetailDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dic[@"status"] intValue] == 200) {
            NSDictionary *data = dic[@"data"];
            self.detailModel = [HotRecommend mj_objectWithKeyValues:data];
            NSArray *images = data[@"shop_free"][@"shop_free_images"];
            for (NSDictionary *imageDic in images) {
                [self.imageArr addObject:imageDic[@"image_url"]];
            }
            self.historyVC = [[BerserkHistoryViewController alloc]initWithID:self.detailModel.id];
            self.historyVC.historyState = HistoryViewStatusWithBerserk;
            [self addChildViewController:self.historyVC];
            self.historyVC.view.hidden = YES;
            [self.view addSubview:self.historyVC.view];
            NSLog(@"image=%@",self.imageArr);
            [self.BerserkView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}


#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

#pragma mark - 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 3){
        return 0;
    }else{
        if (self.pageState == PageStatueWithLead) {
            return 2;
        }else{
            return 1;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *baseCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 1) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row == 0) {
            SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 2)];
            scrollView.imageURLStringsGroup = self.imageArr;
            [baseCell addSubview:scrollView];
            baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return baseCell;
        }else{
            BerserkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BerserkCell" forIndexPath:indexPath];
            cell.goodsName.text = self.detailModel.shop_free[@"title"];
            cell.priceLabel.text = self.detailModel.shop_free[@"price"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 0){
        BerserkeCell_0 *cell_0 = [tableView dequeueReusableCellWithIdentifier:@"BerserkeCell_0" forIndexPath:indexPath];
        cell_0.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_0.cornerRadius = 5;
        cell_0.delegate = self;
        cell_0.titleLabel.text = self.detailModel.shop_free[@"title"];
        cell_0.nextBtn.tag = 1000;
        return cell_0;
    }else if (indexPath.section == 2){
        if (self.pageState == PageStatueWithLead) {
            if (indexPath.row == 0) {
                BerserkCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier:@"BerserkCell_1" forIndexPath:indexPath];
                cell_1.titleLabel.text = @"距离结束:";
                cell_1.hourLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
                cell_1.minuteLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
                cell_1.secondLabel.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
                cell_1.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell_1;
            }else{
                BerserkCell_3 *cell_3 = [tableView dequeueReusableCellWithIdentifier:@"BerserkCell_3" forIndexPath:indexPath];
                cell_3.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell_3;
            }
        }else if (self.pageState == PageStatueWithNomal){
            BerserkCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier:@"BerserkCell_1" forIndexPath:indexPath];
            cell_1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell_1.titleLabel.text = @"即将开始:";
            cell_1.hourLabel.backgroundColor = [UIColor colorWithHexString:@"#62B44D"];
            cell_1.minuteLabel.backgroundColor = [UIColor colorWithHexString:@"#62B44D"];
            cell_1.secondLabel.backgroundColor = [UIColor colorWithHexString:@"#62B44D"];
            return cell_1;
        }else{
            BerserkCell_4 *cell_4 = [tableView dequeueReusableCellWithIdentifier:@"BerserkCell_4" forIndexPath:indexPath];
            cell_4.delegate = self;
            cell_4.awardBtn.tag = 2000;
            cell_4.fabulousBtn.tag = 3000;
            cell_4.replyBtn.tag = 4000;
            cell_4.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell_4;
        }
    }else{
        BerserkCell_2 *cell_2 = [tableView dequeueReusableCellWithIdentifier:@"BerserkCell_2" forIndexPath:indexPath];
        cell_2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell_2;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return kScreenHeight / 2;
        }else{
            return kScreenHeight / 10;
        }
    }else if (indexPath.section == 0){
        return kScreenHeight / 15;
    }else if (indexPath.section == 2){
        if (self.pageState == PageStatueWithNomal) {
            return kScreenHeight / 12;
        }else if (self.pageState == PageStatueWithLead){
            if (indexPath.row == 0) {
                return kScreenHeight / 12;
            }else{
                return kScreenHeight / 4;
            }
        }else{
            return kScreenHeight / 1.4;
        }
    }else{
        return kScreenHeight / 6;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }else if (section == 2){
        return 5;
    }else if (section == 1){
        return 1;
    }
    else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return kScreenHeight / 15;
    }
    else{
        return 0.1;
    }
}

#pragma mark - BaseTableViewcellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)cellRow{
    
    switch (button.tag) {
        case 1000:{
            FlagshipViewController *flagsVC = [[FlagshipViewController alloc]init];
            flagsVC.cid = self.detailModel.id;
            [self.navigationController pushViewController:flagsVC animated:YES];
        }
            break;
        case 2000:{
            
            NSLog(@"开奖规则");
        }
            break;
        case 3000:{
            
            NSLog(@"赞👍");
        }
            break;
        case 4000:{
            MHActionSheet *sheet = [[MHActionSheet alloc]initSheetWithTitle:@"评论" style:MHSheetStyleDefault itemTitles:nil distance:150];
            [sheet show];
            NSLog(@"评论");
        }
            break;
            
        default:
            break;
    }
}

@end
