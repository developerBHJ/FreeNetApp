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

@interface CouponViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,couponHeadViewDelegate>

@property (nonatomic,strong)UICollectionView *couponView;
@property (nonatomic,strong)NSMutableArray *couponData;
@property (nonatomic,strong)NSMutableArray *leftArr;
@property (nonatomic,strong)NSMutableArray *midlleArr;
@property (nonatomic,strong)NSMutableArray *rightArr;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *refreshBtn;
@property (nonatomic,strong)NSMutableDictionary *parameter;
@property (nonatomic,strong)NSString *user_address;

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

-(NSMutableArray *)leftArr{
    
    if (!_leftArr) {
        _leftArr = [NSMutableArray new];
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"全部分类",@"开饭了",@"乐翻天",@"早知道",@"签到有礼",@"餐饮",@"娱乐",@"生活", nil];
        NSArray *subTitles = @[@"35151",@"123",@"12345",@"111",@"87",@"24",@"24569",@"10"];
        NSMutableArray *items = [NSMutableArray arrayWithObjects:@"全部",@"火锅",@"自助餐",@"日韩料理",@"蛋糕甜点",@"烧烤烤鱼",@"粤菜",@"川江菜", nil];
        NSMutableArray *subArr = [NSMutableArray new];
        
        for (int i = 0; i < items.count; i ++) {
            NSArray *arr = [items subarrayWithRange:NSMakeRange(0, i + 1)];
            NSMutableArray *tempArr = [NSMutableArray new];
            for (int i = 0; i < arr.count; i ++) {
                BHJDropModel *model = [[BHJDropModel alloc]init];
                model.title = arr[i];
                model.subTitle = subTitles[i];
                [tempArr addObject:model];
            }
            [subArr addObject:tempArr];
        }
        for (int i = 0; i < titleArr.count; i ++) {
            BHJDropModel *model = [[BHJDropModel alloc]init];
            model.title = titleArr[i];
            model.items = subArr[i];
            model.subTitle = subTitles[i];
            model.imageName = [NSString stringWithFormat:@"coupon_%d",i];
            [_leftArr addObject:model];
        }
    }
    return _leftArr;
}

-(NSMutableArray *)midlleArr{
    
    if (!_midlleArr) {
        _midlleArr = [NSMutableArray new];
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"附近",@"高新区",@"未央区",@"莲湖区",@"雁塔区",@"长安区", nil];
        NSArray *subTitles = @[@"35151",@"123",@"12345",@"111",@"87",@"24",@"24569",@"10"];
        NSMutableArray *items = [NSMutableArray arrayWithObjects:@"全部",@"火锅",@"自助餐",@"日韩料理",@"蛋糕甜点",@"烧烤烤鱼",@"粤菜",@"川江菜", nil];
        NSMutableArray *subArr = [NSMutableArray new];
        
        for (int i = 0; i < items.count; i ++) {
            NSArray *arr = [items subarrayWithRange:NSMakeRange(0, i + 1)];
            NSMutableArray *tempArr = [NSMutableArray new];
            for (int i = 0; i < arr.count; i ++) {
                BHJDropModel *model = [[BHJDropModel alloc]init];
                model.title = arr[i];
                model.subTitle = subTitles[i];
                [tempArr addObject:model];
            }
            [subArr addObject:tempArr];
        }
        for (int i = 0; i < titleArr.count; i ++) {
            BHJDropModel *model = [[BHJDropModel alloc]init];
            model.title = titleArr[i];
            model.items = subArr[i];
            model.subTitle = subTitles[i];
            [_midlleArr addObject:model];
        }
    }
    return _midlleArr;
}

-(NSMutableArray *)rightArr{
    
    if (!_rightArr) {
        _rightArr = [NSMutableArray new];
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"智能排序",@"好评优先",@"离我最近",@"人均最低",@"价格最低",@"价格最高",@"最新发布", nil];
        for (int i = 0; i < titleArr.count; i ++) {
            BHJDropModel *model = [[BHJDropModel alloc]init];
            model.title = titleArr[i];
            [_rightArr addObject:model];
        }
    }
    return _rightArr;
}



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllerStatu = BHJViewControllerStatuCoupon;
    self.leftImage = @"address";
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationAddress:) name:GETLOCATIONNOTIFICATION object:nil];
    
    
    [self setNavgationBarView];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    
    //构造UI
    [self setView];
    
    
    //请求现金券
    [self fetchCashCouponWithURL:API_URL(@"/coupons/lists")];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

-(void)getLocationAddress:(NSNotification *)sender{
    
    NSString *address = sender.userInfo[@"user_address"];
    NSString *city_id = sender.userInfo[@"city_id"];
    if (city_id.length > 0) {
        [self.parameter setValue:city_id forKey:@"region_id"];
    }
    if (address.length > 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"当前位置：%@",address];
        self.user_address = address;
    }else{
        self.titleLabel.text = @"当前位置：正在定位中...";
    }
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



#pragma mark - Collection Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, kScreenHeight / 4);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    cashCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cashCouponCell" forIndexPath:indexPath];
    UIImageView *cornerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 10, kScreenWidth / 10)];
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
        self.titleLabel.text = [NSString stringWithFormat:@"当前位置：%@",self.user_address];
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
    [self.navigationController pushViewController:detailVC animated:YES];
}



#pragma mark >>>> couponHeadViewDelegate
-(void)couponHeadViewMethodWith:(couponHeaderViewStyle)viewStyle selectRow:(NSInteger)row selectedItem:(NSInteger)item{
    
    if (viewStyle == couponHeaderViewStyleWithLeft) {
        if (row == 3 && item == 0) {
            // HairDiscountViewController *discountVC = [[HairDiscountViewController alloc]init];
            //  [self.navigationController pushViewController:discountVC animated:YES];
        }
        NSLog(@"分类%ld    -- %ld",(long)row,item);
    }else if (viewStyle == couponHeaderViewStyleWithMiddle){
        NSLog(@"全城%ld    -- %ld",(long)row,item);
    }else if (viewStyle == couponHeaderViewStyleWithRight){
        NSLog(@"排序%ld    -- %ld",(long)row,item);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self refresh:self.refreshBtn];
}



#pragma mark - 数据请求
-(void)fetchCashCouponWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:@"" forKey:@"lng"]; //经度
    [parameter setValue:@"" forKey:@"lat"]; //维度
    [parameter setValue:@"" forKey:@"industry_id"]; //分区ID
    [parameter setValue:@"" forKey:@"region_id"]; //地区ID
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@",result);
        
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.couponView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
        
    }];
}








@end
