//
//  TopfunViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "TopfunViewController.h"
#import "topFunCell.h"
#import "topFunBuyView.h"
#import "topFunCouponView.h"
#import "QuickspotView.h"
#define DURATION 0.7f

@interface TopfunViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,BaseCollectionViewCellDelegate,BHJCustomViewDelegate>

@property (nonatomic,strong)NSMutableArray *topFunData;

@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *topFunView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIImageView *user_level;
@property (weak, nonatomic) IBOutlet UIImageView *user_head;
@property (weak, nonatomic) IBOutlet UILabel *rechargelabel;

@property (nonatomic,strong) topFunBuyView *buyView;
@property (nonatomic,strong) topFunCouponView *couponView;
@property (nonatomic,strong) QuickspotView *spotView;


@end

@implementation TopfunViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setView];
}

#pragma mark - 懒加载

-(NSMutableArray *)topFunData{
    
    if (!_topFunData) {
        _topFunData = [NSMutableArray new];
    }
    return _topFunData;
}

-(topFunBuyView *)buyView{
    
    if (!_buyView) {
        _buyView = [topFunBuyView shareTopFunBuyView];
        _buyView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _buyView.delegate = self;
        _buyView.buyBtn.tag = 3001;
        _buyView.sinaBtn.tag = 3002;
        _buyView.webChartBtn.tag = 3003;
        _buyView.webCicrleBtn.tag = 3004;
        _buyView.tencentBtn.tag = 3005;
        _buyView.prePrice.lineType = LineTypeMiddle;
    }
    return _buyView;
}

-(topFunCouponView *)couponView{
    
    if (!_couponView) {
        _couponView = [topFunCouponView shareTopFunCouponView];
        _couponView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _couponView.delegate = self;
        _couponView.getBtn.tag = 3006;
        _couponView.sinaBtn.tag = 3002;
        _couponView.webChartBtn.tag = 3003;
        _couponView.webCicrleBtn.tag = 3004;
        _couponView.tencentBtn.tag = 3005;
        
    }
    return _couponView;
}

-(QuickspotView *)spotView{
    
    if (!_spotView) {
        _spotView = [QuickspotView shareQuickspotView];
        _spotView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _spotView.delegate = self;
        _spotView.sinaBtn.tag = 3002;
        _spotView.webChartBtn.tag = 3003;
        _spotView.webCicrleBtn.tag = 3004;
        _spotView.tencentBtn.tag = 3005;
    }
    return _spotView;
}

#pragma mark - 自定义
-(void)setView{
    
    self.navigationItem.title = @"乐翻天";
    [self.topFunView registerNib:[UINib nibWithNibName:@"topFunCell" bundle:nil] forCellWithReuseIdentifier:@"topFunCell"];
    [self.historyBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.changeBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    //    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [rightBtn setFrame:CGRectMake(0, 10, 60, 40)];
    //    [rightBtn setTitle:@"游戏规则" forState:UIControlStateNormal];
    //    [rightBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    //    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    //    [rightBtn setImage:[[UIImage imageNamed:@"right_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    //    [rightBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleRight imageTitleSpace:10];
    //    [rightBtn addTarget:self action:@selector(rule:) forControlEvents:UIControlEventTouchUpInside];
    //    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    //    [rightView addSubview:rightBtn];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"游戏规则 >" style:UIBarButtonItemStylePlain target:self action:@selector(rule:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.topFunView.collectionViewLayout = layout;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _topFunView.backgroundColor = [UIColor whiteColor];
    
    [self.historyBtn setImage:[[UIImage imageNamed:@"Paper"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [self.changeBtn setImage:[[UIImage imageNamed:@"topFun_exchang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
}


- (IBAction)changeData:(UIButton *)sender {
    
    [self.topFunView reloadData];
}


- (IBAction)history:(UIButton *)sender {
    
    
    NSLog(@"历史记录");
}

- (IBAction)reChargeAction:(UIButton *)sender {
    
    RechargeRecordViewController *rechargeVC = [[RechargeRecordViewController alloc]init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

-(void)rule:(UIBarButtonItem *)sender{
    
    NSLog(@"游戏规则");
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    topFunCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topFunCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    cell.selected = NO;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth + 2) / 3,(collectionView.height + 2) / 3 );
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, -1, 0, -1);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    topFunCell *cell = (topFunCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7) {
        [UIView transitionFromView:cell.firstView
                            toView:cell.thirdView
                          duration: DURATION
                           options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                        completion:^(BOOL finished) {
                            if (finished) {
                                cell.thirdView.hidden = NO;
                                cell.secondView.hidden = YES;
                                cell.firstView.hidden = YES;
                            }
                        }
         ];
    }else{
        [UIView transitionFromView:cell.firstView
                            toView:cell.secondView
                          duration: DURATION
                           options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                        completion:^(BOOL finished) {
                            if (finished) {
                                cell.thirdView.hidden = YES;
                                cell.secondView.hidden = NO;
                                cell.firstView.hidden = YES;
                                if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3) {
                                    [self.view addSubview:self.couponView];
                                }else{
                                    [self.view addSubview:self.spotView];
                                    [self.spotView addButtonOnSubView:self.spotView.firstView];
                                    [self.spotView addButtonOnSubView:self.spotView.secondView];
                                    self.spotView.firstView.userInteractionEnabled = YES;
                                    self.spotView.secondView.userInteractionEnabled = YES;
                                }
                            }
                        }
         ];
    }
}


#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    [self.view addSubview:self.buyView];
}
#pragma mark - BHJCustomViewDelegate
-(void)BHJCustomViewMethodWithButton:(UIButton *)sender{
    
    switch (sender.tag) {
        case 3001:{
            NSLog(@"立即购买");
        }
            break;
        case 3002:{
            NSLog(@"新浪微博");
        }
            break;
        case 3003:{
            NSLog(@"微信");
        }
            break;
        case 3004:{
            NSLog(@"微信朋友圈");
        }
            break;
        case 3005:{
            NSLog(@"QQ好友");
        }
            break;
        case 3006:{
            NSLog(@"立即领取");
        }
            break;
            
        default:
            break;
    }
}





@end
