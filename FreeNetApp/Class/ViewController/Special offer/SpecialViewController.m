//
//  SpecialViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "SpecialViewController.h"
#import "homeCell.h"
#import "homeFooterView.h"
#import "RecommendCell.h"
#import "SpecialDetailViewController.h"
#import "Banner.h"
#import "SpecialModel.h"

#define SpecialUrl @"http://192.168.0.254:4004/special/lists"

@interface SpecialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate,BHJReusableViewDelegate>

@property (nonatomic,strong)UICollectionView *specialCollectionView;
@property (nonatomic,strong)NSMutableDictionary *specialData;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)NSMutableDictionary *parameter;

@end

@implementation SpecialViewController

#pragma mark >>>> 懒加载
-(UICollectionView *)specialCollectionView{
    
    if (!_specialCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _specialCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _specialCollectionView.delegate = self;
        _specialCollectionView.dataSource = self;
        _specialCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _specialCollectionView;
}

-(NSMutableDictionary *)specialData{
    
    if (!_specialData) {
        _specialData = [NSMutableDictionary new];
    }
    return _specialData;
}

-(NSMutableArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr = [NSMutableArray arrayWithArray:@[@"a1",@"a2",@"a3",@"a4"]];
    }
    return _imageArr;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"region_id",@"1",@"page", nil];
    }
    return _parameter;
}
#pragma mark >>>> 生命周期
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllerStatu = BHJViewControllerStatuSpecial;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedCity:) name:@"selectedCity" object:nil];
    [self setNavgationBarView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    [self getData];
    [self setView];
}
#pragma mark >>>> 自定义
// 搜索
-(void)searchAction:(UIBarButtonItem *)sender{
    
    BHJSearchViewController *searchVC = [[BHJSearchViewController alloc]init];
    searchVC.viewControllerStatu = BHJViewControllerStatuSpecial;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)setView{
    
    self.navigationItem.title = @"特价";
    self.specialCollectionView.backgroundColor = HWColor(239, 239, 239, 1.0);
    
    [self.view addSubview:self.specialCollectionView];
    
    [self.specialCollectionView registerNib:[UINib nibWithNibName:@"homeCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
    [self.specialCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.specialCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.specialCollectionView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCell"];
    
    [self.specialCollectionView registerNib:[UINib nibWithNibName:@"homeFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeFooterView"];
    
}


-(void)getData{
    
    NSMutableArray *firstArr = [NSMutableArray arrayWithArray:@[@"home_1",@"home_2",@"home_3",@"home_4",@"home_5",@"home_6",@"home_7",@"home_8"]];
    NSMutableArray *themeArr = [NSMutableArray arrayWithArray:@[@"开饭啦",@"乐翻天",@"充值",@"签到有礼",@"餐饮",@"娱乐",@"生活",@"更多"]];
    [self.specialData setObject:themeArr forKey:@"theme"];
    [self.specialData setObject:firstArr forKey:@"section_1"];
    
    NSMutableArray *secondArr = [NSMutableArray arrayWithArray:@[@"store_image",@"banner_2"]];
    [self.specialData setObject:secondArr forKey:@"section_2"];
    NSMutableArray *timeArr = [NSMutableArray arrayWithArray:@[@"12:00",@"14:00",@"16:00",@"19:00",@"21:00"]];
    [self.specialData setObject:timeArr forKey:@"time"];
    // 请求数据
    [self getSpecialDataWithUrl:SpecialUrl parameter:self.parameter];
    // 轮播图
    NSString *str = [BannerUrl stringByAppendingString:@"1"];
    [self getSpecialBannerWith:str parameter:nil];
}


-(void)selectedCity:(NSNotification *)sender{
    
    NSString *currentCity = sender.userInfo[@"userCity"];
    NSString *city_id = sender.userInfo[@"city_id"];
    if (city_id.length > 0) {
        [self.parameter setValue:city_id forKey:@"region_id"];
    }
    if (currentCity.length > 0) {
        [self.locationBtn setTitle:currentCity forState:UIControlStateNormal];
    }
    [self getSpecialDataWithUrl:SpecialUrl parameter:self.parameter];
}
#pragma mark >>>> 网络获取数据
-(void)getSpecialBannerWith:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfo:url parameters:parameter success:^(id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                Banner *banner = [Banner mj_objectWithKeyValues:dic];
                [data addObject:banner];
            }
        }
        [self.specialData setObject:data forKey:@"banner"];
        [self.specialCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

// 特价数据
-(void)getSpecialDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                SpecialModel *model = [SpecialModel mj_objectWithKeyValues:dic];
                [data addObject:model];
            }
        }
        [self.specialData setObject:data forKey:@"like"];
        [self.specialCollectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark >>>> UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0){
        return 8;
    }else {
        NSArray *data = [self.specialData objectForKey:@"like"];
        return data.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        NSMutableArray *arr = [self.specialData objectForKey:@"section_1"];
        homeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
        NSArray *themeArr = [self.specialData objectForKey:@"theme"];
        cell.titleLabel.text = themeArr[indexPath.row];
        cell.markImage.image = [[UIImage imageNamed:arr[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [cell.markImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
        cell.markImage.contentMode =  UIViewContentModeScaleAspectFit;
        cell.markImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.markImage.clipsToBounds  = YES;
        return cell;
    }else {
        RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
        NSArray *data = [self.specialData objectForKey:@"like"];
        cell.model = data[indexPath.row];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreenHeight / 15, kScreenHeight / 15)];
        if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 0) {
            imageView.image = [[UIImage imageNamed:@"taocan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else{
            imageView.image = [[UIImage imageNamed:@"yuyue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        [cell addSubview:imageView];
        return cell;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        return CGSizeMake((kScreenWidth - 35) / 4, 81);
    }
    return CGSizeMake(kScreenWidth, 95);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    if (section == 1){
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }else{
        return UIEdgeInsetsMake(10, 10, 5, 10);
    }
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        for (UIView *view in headView.subviews) {
            [view removeFromSuperview];
        }
        if (indexPath.section == 0) {
            SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
            NSArray *banner = [self.specialData objectForKey:@"banner"];
            NSMutableArray *images = [NSMutableArray new];
            for (Banner *model in banner) {
                [images addObject:model.image_url];
            }
            scrollView.imageURLStringsGroup = images;
            [headView addSubview:scrollView];
        }else if (indexPath.section == 1){
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(headView.frame) - 20, CGRectGetHeight(headView.frame) - 20)];
            titleLabel.text = @"猜你喜欢";
            headView.backgroundColor = [UIColor whiteColor];
            [titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:18]];
            titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            [headView addSubview:titleLabel];
        }
        return headView;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        homeFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeFooterView" forIndexPath:indexPath];
        footerView.allBtn.tag = 500;
        footerView.delegate = self;
        footerView.viewController = self;
        footerView.indexPath = indexPath;
        if (indexPath.section == 1) {
            return footerView;
        }
    }
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 120);
    }else {
        return CGSizeMake(kScreenWidth - 20, 40);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return CGSizeMake(kScreenWidth, 38);
    }else{
        return CGSizeMake(0, 0);
    }
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        return 2;
    }else{
        return 5;
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        return 2;
    }else{
        return 5;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            [self.navigationController pushViewController:[CalendarViewController sharedCalendarViewController] animated:YES];
        }else if (indexPath.row == 1){
            TopfunViewController *topFanVC = [[TopfunViewController alloc]init];
            [self.navigationController pushViewController:topFanVC animated:YES];
        }else if (indexPath.row == 2){
            RechargeRecordViewController *rechargeVC = [[RechargeRecordViewController alloc]init];
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }else if (indexPath.row == 0){
            OpenRiceViewController *openVC = [[OpenRiceViewController alloc]init];
            [self.navigationController pushViewController:openVC animated:YES];
        }else if (indexPath.row == 4){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.type = @(1);
            restaurantVC.viewStyle = ViewStleWithSpecialData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 5){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.type = @(2);
            restaurantVC.viewStyle = ViewStleWithSpecialData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 6){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.type = @(3);
            restaurantVC.viewStyle = ViewStleWithSpecialData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else{
            MoreClassViewController *moreVC = [[MoreClassViewController alloc]init];
            [self.navigationController pushViewController:moreVC animated:YES];
        }
    }else if (indexPath.section == 1){
        
        NSArray *data = [self.specialData objectForKey:@"like"];
        SpecialModel *model = data[indexPath.row];
        SpecialDetailViewController *detailVC = [[SpecialDetailViewController alloc]init];
        detailVC.lid = model.id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark >>> BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    if (button.tag == 200) {
        NSLog(@"cellRow:%ld tag:%ld",(long)index.row,button.tag);
    }else{
        NSLog(@"cellRow:%ld tag:%ld",(long)index.row,button.tag);
    }
}

#pragma mark >>> BHJReusableViewDelegate
-(void)BHJReusableViewDelegateMethodWithIndexPath:(NSIndexPath *)indexPath button:(UIButton *)button{
    
    switch (button.tag) {
        case 500:{
            NSLog(@"查看全部");
        }
        default:
            break;
    }
}

@end
