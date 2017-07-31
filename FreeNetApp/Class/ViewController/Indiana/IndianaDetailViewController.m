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
#import "BHJIndianaBottomView.h"
#define DURATION 0.3f

#define DetailUrl @"http://192.168.0.254:4004/indiana/list_detail"

@interface IndianaDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BHJIndianaBottomViewDelegate>

@property (nonatomic,strong)UITableView *BerserkView;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)BHJIndianaBottomView *bottomView;
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
        _BerserkView = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth - 20, kScreenHeight - 113) style:UITableViewStyleGrouped];
        _BerserkView.delegate = self;
        _BerserkView.dataSource = self;
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

- (UIScrollView *)bottomScrollView {
    
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        [self.bottomScrollView addSubview:self.BerserkView];
        
        //  NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        //  [self.BerserkView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
    return _bottomScrollView;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.lid,@"lid",nil];
    }
    return _parameter;
}


-(BHJIndianaBottomView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[BHJIndianaBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getIndianaDetailDataWithUrl:DetailUrl parameter:self.parameter];
    
    [self setUpView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailState = DetailViewStatusWithNomal;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.bottomView removeFromSuperview];
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"timeOut" object:nil];
    // [self.BerserkView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)setHeadView{
    
    SDCycleScrollView *scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth - 20, kScreenHeight / 2 - 50) imageURLStringsGroup:self.imageArr];
    _cycleScrollView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, kScreenHeight / 2)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, scrollview.bottom + 7, _cycleScrollView.width - 40, 15)];
    titleLabel.text = self.detailModel.treasure[@"title"];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    titleLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, titleLabel.bottom + 5, _cycleScrollView.width, 15)];
    priceLabel.textColor = [UIColor colorWithHexString:@"#e4504b"];
    [priceLabel setFont:[UIFont systemFontOfSize:15]];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:self.detailModel.treasure[@"price"]];
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
    _BerserkView.tableHeaderView = self.cycleScrollView;
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
    
    [self.view addSubview:self.bottomScrollView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
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
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        weak.detailModel = [IndianaDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSArray *arr = self.detailModel.treasure[@"treasure_images"];
        for (NSDictionary *dic in arr) {
            [weak.imageArr addObject:dic[@"image_url"]];
        }
        [self setHeadView];
        [weak.BerserkView reloadData];
        
        self.historyVC = [[BerserkHistoryViewController alloc]initWithID:self.detailModel.id];
        self.historyVC.historyState = HistoryViewStatusWithIndiana;
        [self addChildViewController:self.historyVC];
        self.historyVC.view.hidden = YES;
        [self.view addSubview:self.historyVC.view];
        
        self.isLandVC = [[IndianaIslandViewController alloc]initWithID:self.detailModel];
        [self addChildViewController:self.isLandVC];
        self.isLandVC.view.hidden = YES;
        [self.view addSubview:self.isLandVC.view];
    } failure:^(NSError * _Nullable error) {
        
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

#pragma mark - BHJIndianaBottomViewDelegate
//  底部按钮回调方法
-(void)indianaBottomViewClick:(UIButton *)sender{
    
    switch (sender.tag) {
        case 500:{
            self.isShow = !self.isShow;
            if (self.isShow) {
                [self showView:self.historyVC.view];
                self.navigationItem.title = @"出价记录";
            }else{
                [self hiddenView:self.historyVC.view];
                self.navigationItem.title = @"夺宝岛";
            }
        }
            break;
        case 501:{
            self.isShow = !self.isShow;
            if (self.isShow) {
                [self showView:self.isLandVC.view];
            }else{
                [self hiddenView:self.isLandVC.view];
            }
        }
            break;
        case 502:{
            [self hiddenView:self.historyVC.view];
            [self hiddenView:self.isLandVC.view];
            [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
        }
            break;
        case 503:{
            self.detailState = DetailViewStatusWithWinning;
            [self.BerserkView reloadData];
        }
            break;
            
        default:
            break;
    }
}

@end
