//
//  IndianaDetailViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/13.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "IndianaDetailViewController.h"
#import "indianaDetailCell_1.h"
#import "BerserkHeadView.h"
#import "BerserkHistoryViewController.h"
#import "indianaBottomView.h"
#import "IndianaIslandViewController.h"
#import "indianaDetailHeaderView.h"
#import "indianaDetailWinningView.h"
#import "IndianaDetailModel.h"
#define DURATION 0.3f

#define DetailUrl @"http://192.168.0.254:1000/ingots/ingot_details"

@interface IndianaDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)UITableView *BerserkView;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)JXButton *selectBtn;
@property (nonatomic,assign)BOOL isClick;
@property (nonatomic,assign)BOOL isShow;

@property (nonatomic, strong) UIView *cycleScrollView;
//记录上一个偏移量
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;
@property (nonatomic, strong) UIScrollView *bottomScrollView;

@property (nonatomic,strong)indianaBottomView *popView;
@property (nonatomic,strong)BerserkHistoryViewController *historyVC;
@property (nonatomic,strong)IndianaIslandViewController *isLandVC;
@property (nonatomic,strong)NSMutableDictionary *parameter;

@property (nonatomic,strong)IndianaDetailModel *detailModel;

@end

@implementation IndianaDetailViewController

#pragma mark - 懒加载
-(UITableView *)BerserkView{
    
    if (!_BerserkView) {
        _BerserkView = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth - 20, kScreenHeight - 50) style:UITableViewStyleGrouped];
        _BerserkView.delegate = self;
        _BerserkView.dataSource = self;
        // _BerserkView.tableHeaderView = self.cycleScrollView;
    }
    return _BerserkView;
}

-(NSMutableArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}

-(indianaBottomView *)popView{
    
    if (!_popView) {
        _popView = [indianaBottomView shareIndianaBottomView];
        _popView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self setViewWithTextField:_popView.firstTF imageName:@"subAction_gray" anotherImage:@"add_gray"];
        [self setViewWithTextField:_popView.secondTF imageName:@"subAction_gray" anotherImage:@"add_gray"];
    }
    return _popView;
}

- (UIView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        SDCycleScrollView *scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth - 20, kScreenHeight / 2 - 50) imageURLStringsGroup:self.imageArr];
        _cycleScrollView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, kScreenHeight / 2)];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, scrollview.bottom + 7, _cycleScrollView.width - 40, 15)];
        titleLabel.text = self.model.name;
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        titleLabel.textColor = [UIColor colorWithHexString:@"#696969"];
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, titleLabel.bottom + 5, _cycleScrollView.width, 15)];
        priceLabel.textColor = [UIColor colorWithHexString:@"#e4504b"];
        [priceLabel setFont:[UIFont systemFontOfSize:15]];
        NSString *str = [NSString stringWithFormat:@"¥%@",self.model.snatch_price];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        priceLabel.attributedText = attStr;
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setFrame:CGRectMake(_cycleScrollView.right - 30, titleLabel.centerY - 5, 10, 12)];
        [nextBtn setBackgroundImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIView *divisionLine = [[UIView alloc]initWithFrame:CGRectMake(0, _cycleScrollView.height - 5, _cycleScrollView.width, 5)];
        divisionLine.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        //        [_cycleScrollView addSubview:divisionLine];
        [_cycleScrollView addSubview:nextBtn];
        [_cycleScrollView addSubview:priceLabel];
        [_cycleScrollView addSubview:titleLabel];
        [_cycleScrollView addSubview:scrollview];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
        _cycleScrollView.cornerRadius = 5;
    }
    return _cycleScrollView;
}

- (UIScrollView *)bottomScrollView {
    
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        [self.bottomScrollView addSubview:self.BerserkView];
        
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [self.BerserkView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
    return _bottomScrollView;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(self.model.id),@"id",nil];
    }
    return _parameter;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getIndianaDetailDataWithUrl:DetailUrl parameter:self.parameter];

    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [self setUpView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailState = DetailViewStatusWithNomal;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    [self.bottomView removeFromSuperview];
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"timeOut" object:nil];
    [self.BerserkView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UITableView *tableView = (UITableView *)object;
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    __weak typeof(self) weakself = self;
    CGFloat tableViewoffsetY = tableView.contentOffset.y;
    self.lastTableViewOffsetY = tableViewoffsetY;
    
    if ( tableViewoffsetY >= 0 && tableViewoffsetY <= (kScreenHeight / 2 - 64)) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:(tableViewoffsetY - 64) / 64];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                self.cycleScrollView.frame = CGRectMake(10, -tableViewoffsetY, kScreenWidth - 20, kScreenHeight / 2);
                weakself.BerserkView.frame = CGRectMake(10, weakself.cycleScrollView.bottom + 7, kScreenWidth - 20, kScreenHeight);
            } completion:^(BOOL finished) {
                
            }];
        });
        
    }else if( tableViewoffsetY < 0){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                self.cycleScrollView.frame = CGRectMake(10, 0, kScreenWidth - 20, kScreenHeight / 2);
                weakself.BerserkView.frame = CGRectMake(10, weakself.cycleScrollView.bottom + 7, kScreenWidth - 20, kScreenHeight);
            } completion:^(BOOL finished) {
                
            }];
        });
    }else if (tableViewoffsetY > (kScreenHeight / 2 - 64)){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                self.cycleScrollView.frame = CGRectMake(10, -kScreenHeight / 2, kScreenWidth - 20, 0);
                weakself.BerserkView.frame = CGRectMake(10, 64, kScreenWidth - 20, kScreenHeight - 108);
            } completion:^(BOOL finished) {
                
            }];
        });
    }
}
#pragma mark - 自定义
-(void)setUpView{
    
    self.navigationItem.title = @"夺宝岛";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithTitle:@"游戏规则" style:UIBarButtonItemStylePlain target:self action:@selector(gameRule:)];
    [right1 setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[right,right1];
    [self.BerserkView registerNib:[UINib nibWithNibName:@"indianaDetailCell_1" bundle:nil] forCellReuseIdentifier:@"indianaDetailCell_1"];
    
    [self setBottomView];
    [self.view addSubview:self.bottomScrollView];
    [self.view addSubview:self.cycleScrollView];

    
    self.historyVC = [[BerserkHistoryViewController alloc]init];
    self.historyVC.historyState = HistoryViewStatusWithIndiana;
    [self addChildViewController:self.historyVC];
    self.historyVC.view.hidden = YES;
    [self.view addSubview:self.historyVC.view];
    
    self.isLandVC = [[IndianaIslandViewController alloc]init];
    [self addChildViewController:self.isLandVC];
    self.isLandVC.view.hidden = YES;
    [self.view addSubview:self.isLandVC.view];
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
    
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerBtn setFrame:CGRectMake(5, 5, 50, 50)];
    centerBtn.cornerRadius = centerBtn.width / 2;
    [centerBtn setTitle:@"一键 \n 购买" forState:UIControlStateNormal];
    centerBtn.titleLabel.numberOfLines = 0;
    [centerBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    centerBtn.borderColor = [UIColor colorWithHexString:@"#e4504b"];
    centerBtn.borderWidth = 5;
    centerBtn.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    [centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:centerBtn];
    
    CGFloat btnWidth = (kScreenWidth - CGRectGetWidth(centerView.frame)) / 5;
    CGFloat btnHeight = CGRectGetHeight(self.bottomView.frame);
    JXButton *historyButton = [[BHJTools sharedTools]creatButtonWithTitle:@"出价记录" image:@"berserk_1_nomal" selector:@selector(bottomEvent:) Frame:CGRectMake(10, 5, btnWidth, btnHeight - 8) viewController:self selectedImage:@"berserk_1_selected" tag:500];
    [self.bottomView addSubview:historyButton];
    JXButton *secondButton = [[BHJTools sharedTools]creatButtonWithTitle:@"砸价" image:@"fire_gray" selector:@selector(bottomEvent:) Frame:CGRectMake(CGRectGetMaxX(centerView.frame) + 10, 5, btnWidth, btnHeight - 8) viewController:self selectedImage:@"fire_red" tag:501];
    [self.bottomView addSubview:secondButton];
    JXButton *thirdButton = [[BHJTools sharedTools]creatButtonWithTitle:@"出价" image:@"charge_gray" selector:@selector(bottomEvent:) Frame:CGRectMake(kScreenWidth - btnWidth - 10, 5, btnWidth, btnHeight - 8) viewController:self selectedImage:@"charge_red" tag:502];
    [self.bottomView addSubview:thirdButton];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
}

//  底部按钮回调方法
-(void)bottomEvent:(JXButton *)sender{
    
    [self setSelectedButton:sender];
    switch (sender.tag) {
        case 500:{
            if (!self.isClick) {
                if (self.isShow) {
                    [self hiddenView:self.isLandVC.view];
                    self.isShow = NO;
                }
                [self showView:self.historyVC.view];
                self.navigationItem.title = @"出价记录";
                self.isClick = YES;
            }else{
                [self hiddenView:self.historyVC.view];
                self.navigationItem.title = @"夺宝岛";
                self.isClick = NO;
            }
        }
            break;
        case 501:{
            if (!self.isShow) {
                if (self.isClick) {
                    [self hiddenView:self.historyVC.view];
                    self.isClick = NO;
                }
                [self showView:self.isLandVC.view];
                self.isShow = YES;
            }else{
                [self hiddenView:self.isLandVC.view];
                self.isShow = NO;
            }
        }
            break;
        case 502:{
            [self hiddenView:self.isLandVC.view];
            [self hiddenView:self.historyVC.view];
            [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
        }
            break;
            
        default:
            break;
    }
}

-(void)centerBtnClick:(UIButton *)sender{
    
    self.detailState = DetailViewStatusWithWinning;
    [self.BerserkView reloadData];
}

-(void)setSelectedButton:(JXButton *)sender{
    
    if (sender.selected) {
        sender.selected = NO;
        self.selectBtn.selected = YES;
    }else{
        self.selectBtn.selected = NO;
        sender.selected = YES;
    }
    self.selectBtn = sender;
}


-(void)rightBtn:(UIButton *)sender{
    
    NSLog(@"啊但是款式");
}

// 分享
-(void)share:(UIBarButtonItem *)sender{
    
    [[BHJTools sharedTools]showShareView];
}

// 游戏规则
-(void)gameRule:(UIButton *)sender{
    
    NSLog(@"游戏规则");
}

// 展示夺宝记录页面
-(void)showView:(UIView *)view{
    
    [UIView animateWithDuration:DURATION animations:^{
        [self transitionWithType:kCATransitionMoveIn WithSubtype:kCATransitionFromLeft ForView:view];
        view.hidden = NO;
    } completion:^(BOOL finished) {
        view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    }];
}

// 隐藏夺宝记录页面
-(void)hiddenView:(UIView *)view{
    
    [UIView animateWithDuration:DURATION animations:^{
        [self transitionWithType:kCATransitionMoveIn WithSubtype:kCATransitionFromRight ForView:self.view];
        view.hidden = YES;
    } completion:^(BOOL finished) {
        
    }];
}
// 设置textField左右视图
-(void)setViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName anotherImage:(NSString *)image{
    
    UIView *rightView = [[UIView alloc]init];
    rightView.size = CGSizeMake(30, CGRectGetHeight(textField.frame));
    rightView.borderColor = [UIColor lightGrayColor];
    rightView.borderWidth = 1.0;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(CGRectGetWidth(rightView.frame) / 4, CGRectGetHeight(rightView.frame) / 4, CGRectGetWidth(rightView.frame) / 2, CGRectGetHeight(rightView.frame) / 2.2)];
    [rightView addSubview:rightBtn];
    //    [rightBtn setTitle:@"+" forState:UIControlStateNormal];
    //    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [rightBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    rightView.contentMode = UIViewContentModeRedraw;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc]init];
    leftView.size = CGSizeMake(30, CGRectGetHeight(textField.frame));
    leftView.borderColor = [UIColor lightGrayColor];
    leftView.borderWidth = 1.0;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    //    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [leftBtn setFrame:CGRectMake(CGRectGetWidth(leftView.frame) / 4, CGRectGetHeight(leftView.frame) / 4, CGRectGetWidth(leftView.frame) / 2, CGRectGetHeight(leftView.frame) / 2.2)];
    [leftView addSubview:leftBtn];
    //    [leftBtn setTitle:@"-" forState:UIControlStateNormal];
    //    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(subtractionAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentMode = UIViewContentModeRedraw;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

-(void)addBtnAction:(UIButton *)sender{
    
    NSLog(@"+++");
}

-(void)subtractionAction:(UIButton *)sender{
    
    NSLog(@"----");
}
#pragma mark - 请求网络数据
-(void)getIndianaDetailDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        self.detailModel = [IndianaDetailModel mj_objectWithKeyValues:data];
        NSArray *arr = data[@"images"];
        for (NSDictionary *dic in arr) {
            [self.imageArr addObject:dic[@"image_path"]];
        }
        [self.BerserkView reloadData];
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

#pragma mark - 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 0;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    indianaDetailCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"indianaDetailCell_1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        if (self.detailState == DetailViewStatusWithWinning) {
            indianaDetailWinningView *headView = [indianaDetailWinningView shareIndianaDetailWinningView];
            headView.model = self.detailModel;
            return headView;
        }else{
            indianaDetailHeaderView *headView = [indianaDetailHeaderView shareIndianaDetailHeaderView];
            [headView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(5, 5)];
            headView.model = self.detailModel;
            return headView;
        }
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.detailState == DetailViewStatusWithWinning) {
        return kScreenHeight / 4;
    }else{
        return kScreenHeight / 2.8;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}
#pragma mark - BaseTableViewcellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    switch (button.tag) {
            
        case 2000:{
            
            NSLog(@"开奖规则");
        }
            break;
            
        default:
            break;
    }
}


@end
