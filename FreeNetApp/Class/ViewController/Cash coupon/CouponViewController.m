//
//  CouponViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "CouponViewController.h"
#import "cashCouponCell.h"
#import "CashDetailViewController.h"
#import "HairDiscountViewController.h"
#import "couponHeadView.h"
#import "BHJDropModel.h"
#import "CashCouponModel.h"
#import "ClassModel.h"
#define kCouponUrl @"http://192.168.0.254:4004/coupons/lists"
#define kMoreUrl @"http://192.168.0.254:4004/publics/industries"
#define kSubClassUrl @"http://192.168.0.254:4004/publics/cates"
@interface CouponViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,couponHeadViewDelegate>

@property (nonatomic,strong)UICollectionView *couponView;
@property (nonatomic,strong)NSMutableArray *couponData;
@property (nonatomic,strong)NSMutableArray *midlleArr;
@property (nonatomic,strong)NSMutableArray *rightArr;
@property (nonatomic,strong)NSMutableArray *leftArr;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *refreshBtn;
@property (nonatomic,strong)NSMutableDictionary *parameter;
@property (nonatomic,strong)NSString *user_address;
@property (nonatomic,strong)NSMutableDictionary *classDic;

@end

@implementation CouponViewController
#pragma mark - Init
-(UICollectionView *)couponView{
    
    if (!_couponView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _couponView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 46, kScreenWidth, kScreenHeight - 46) collectionViewLayout:layout];
        _couponView.delegate = self;
        _couponView.dataSource = self;
        _couponView.backgroundColor = HWColor(239, 239, 239, 1.0);
    }
    return _couponView;
}

-(NSMutableArray *)couponData{
    
    if (!_couponData) {
        _couponData = [NSMutableArray new];
    }
    return _couponData;
}

-(NSMutableDictionary *)classDic{
    
    if (!_classDic) {
        _classDic = [NSMutableDictionary new];
    }
    return _classDic;
}

-(NSMutableArray *)leftArr{
    
    if (!_leftArr) {
        _leftArr = [NSMutableArray new];
    }
    return _leftArr;
}

-(NSMutableArray *)midlleArr{
    
    if (!_midlleArr) {
        _midlleArr = [NSMutableArray new];
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"附近",@"高新区",@"未央区",@"莲湖区",@"雁塔区",@"长安区", nil];
        for (int i = 0; i < titleArr.count; i ++) {
            BHJDropModel *model = [[BHJDropModel alloc]init];
            model.name = titleArr[i];
            [_midlleArr addObject:model];
        }
    }
    return _midlleArr;
}

-(NSMutableArray *)rightArr{
    
    if (!_rightArr) {
        _rightArr = [NSMutableArray new];
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"智能排序",@"价格最低",@"价格最高",@"最新发布", nil];
        for (int i = 0; i < titleArr.count; i ++) {
            BHJDropModel *model = [[BHJDropModel alloc]init];
            model.name = titleArr[i];
            [_rightArr addObject:model];
        }
    }
    return _rightArr;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithDictionary:@{@"lng":@"100",@"lat":@"34",@"industry_id":@(1),@"region_id":@(2),@"page":@(1),@"types":@(1)}];
    }
    return _parameter;
}


#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllerStatu = BHJViewControllerStatuCoupon;
    self.leftImage = @"address";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationAddress:) name:GETLOCATIONNOTIFICATION object:nil];
    
    [self setNavgationBarView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
    [self getMoreClassData];
    //构造UI
    [self setView];
    
    //请求现金券
    [self fetchCashCouponWithURL:kCouponUrl paramater:self.parameter];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - NSNotification
-(void)getLocationAddress:(NSNotification *)sender{
    
    NSString *address = sender.userInfo[@"user_address"];
    NSString *city_id = sender.userInfo[@"city_id"];
    if (city_id.length > 0) {
        [self.parameter setValue:city_id forKey:@"region_id"];
    }
    self.titleLabel.text = address.length > 0 ? [NSString stringWithFormat:@"当前位置：%@",address] : @"正在定位中...";
    [self.couponView reloadData];
}

#pragma mark - 自定义
// 搜索
-(void)searchAction:(UIBarButtonItem *)sender{
    
    BHJSearchViewController *searchVC = [[BHJSearchViewController alloc]init];
    searchVC.viewControllerStatu = BHJViewControllerStatuCoupon;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)setView{
    
    self.navigationItem.title = @"商城-现金券";
    [self.view addSubview:self.couponView];
    [self.couponView registerNib:[UINib nibWithNibName:@"cashCouponCell" bundle:nil] forCellWithReuseIdentifier:@"cashCouponCell"];
    [self.couponView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    couponHeadView *headView = [couponHeadView shareCouponHeadView];
    headView.isCoupon = YES;
    headView.leftData = self.leftArr;
    headView.middleData = self.midlleArr;
    headView.rightData = self.rightArr;
    [headView.allBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    [headView.locationBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    [headView.sortBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    headView.frame = CGRectMake(0, 64, kScreenWidth, 44);
    headView.delegate = self;
    [self.view addSubview:headView];
}

-(void)refresh:(UIButton *)sender{
    
    [UIView transitionWithView:self.refreshBtn duration:2 options:UIViewAnimationOptionCurveLinear animations:^{
        self.refreshBtn.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        self.refreshBtn.transform = CGAffineTransformMakeRotation(0);
    }];
}

/**
 获取一级分类信息
 */
-(void)getMoreClassData{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:kMoreUrl parameters:nil success:^(id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            NSArray *data = [NSArray new];
            data = [ClassModel mj_objectArrayWithKeyValuesArray:arr];
            for (ClassModel *model in data) {
                NSDictionary *paramater = [NSDictionary dictionaryWithObjectsAndKeys:model.id,@"lid",model,@"model",nil];
                [self getSubClassDataWith:paramater];
            }
            [weak.classDic setObject:data forKey:@"class"];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取二级分类信息
 */
-(void)getSubClassDataWith:(NSDictionary *)paramater{
    
    __block NSArray *data = [NSArray new];
    ClassModel *classModel = [paramater objectForKey:@"model"];
    BHJDropModel *dropM = [[BHJDropModel alloc]init];
    dropM.name = classModel.title;
    dropM.headImage = classModel.cover_url;
    dropM.id = classModel.id;
    NSMutableArray *subDrop = [NSMutableArray new];
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:kSubClassUrl parameters:paramater success:^(id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            data = [ClassModel mj_objectArrayWithKeyValuesArray:arr];
            for (ClassModel *model1 in data) {
                BHJDropModel *dropM1 = [[BHJDropModel alloc]init];
                dropM1.name = model1.title;
                dropM1.headImage = model1.cover_url;
                dropM1.id = model1.id;
                [subDrop addObject:dropM1];
            }
        }
        dropM.items = [NSArray arrayWithArray:subDrop];
        [weak.leftArr addObject:dropM];
      //  NSLog(@"%@    %@",weak.leftArr,dropM.items);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - Collection Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.couponData.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, 142);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    cashCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cashCouponCell" forIndexPath:indexPath];
    UIImageView *cornerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 10, kScreenWidth / 10)];
    cell.model = self.couponData[indexPath.row];
    if (indexPath.row == 0 || indexPath.row == 2) {
        cornerView.image = [[UIImage imageNamed:@"yuyue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        cornerView.image = [[UIImage imageNamed:@"taocan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [cell.goods_image addSubview:cornerView];
    
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreenWidth - 50, 20)];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [headView addSubview:self.titleLabel];
        
        self.refreshBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:nil image:@"refresh" selector:@selector(refresh:) Frame:CGRectMake(kScreenWidth - 30, 5, 25, 25) viewController:self selectedImage:nil tag:2000];
        [headView addSubview:self.refreshBtn];
        return headView;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CashDetailViewController *detailVC = [[CashDetailViewController alloc]init];
    detailVC.model = self.couponData[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 5;
}
#pragma mark - couponHeadViewDelegate
-(void)couponHeadViewMethodWith:(couponHeaderViewStyle)viewStyle selectRow:(NSInteger)row selectedItem:(NSInteger)item{
    
    [self.couponData removeAllObjects];
    if (viewStyle == couponHeaderViewStyleWithLeft) {
        BHJDropModel *model = self.leftArr[row];
        BHJDropModel *subModel = nil;
        if (item >= 0) {
            subModel = model.items[item];
        }else{
            subModel = model.items[item + 1];
        }
        [self.parameter setValue:subModel.id forKey:@"industry_id"];
        [self fetchCashCouponWithURL:kCouponUrl paramater:self.parameter];
    }else if (viewStyle == couponHeaderViewStyleWithMiddle){
        [self.parameter setValue:@(2) forKey:@"region_id"];
        [self fetchCashCouponWithURL:kCouponUrl paramater:self.parameter];
    }else if (viewStyle == couponHeaderViewStyleWithRight){
        
        [self.parameter setValue:@(row + 1) forKey:@"types"];
        [self fetchCashCouponWithURL:kCouponUrl paramater:self.parameter];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self refresh:self.refreshBtn];
}

#pragma mark - 数据请求
-(void)fetchCashCouponWithURL:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    NSLog(@"paramater=%@",paramater);
    [[BHJNetWorkTools sharedNetworkTool] loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            weak.couponData = [CashCouponModel mj_objectArrayWithKeyValuesArray:arr];
        }
        [weak.couponView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
