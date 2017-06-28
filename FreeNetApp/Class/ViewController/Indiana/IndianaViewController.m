//
//  IndianaViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "IndianaViewController.h"
#import "homeCell.h"
#import "homeFooterView.h"
#import "indianaCell.h"
#import "indianaCell_1.h"

#import "IndianaIslandViewController.h"
#import "IndianaDetailViewController.h"
#import "UINavigationBar+NavigationBarBackground.h"
#import "Banner.h"
#import "IndianaModel.h"

#define IndianaUrl @"http://192.168.0.254:4004/indiana/lists"
#define kIndianaHot @"http://192.168.0.254:4004/indiana/hot_lists"

@interface IndianaViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate,BHJReusableViewDelegate>

@property (nonatomic,strong)UICollectionView *indianaCollectionView;
@property (nonatomic,strong)NSMutableDictionary *indianaData;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)NSMutableDictionary *parameter;


@end

@implementation IndianaViewController
#pragma mark >>>> 懒加载
-(UICollectionView *)indianaCollectionView{
    
    if (!_indianaCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _indianaCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _indianaCollectionView.delegate = self;
        _indianaCollectionView.dataSource = self;
        _indianaCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _indianaCollectionView;
}

-(NSMutableDictionary *)indianaData{
    
    if (!_indianaData) {
        _indianaData = [NSMutableDictionary new];
    }
    return _indianaData;
}

-(NSMutableArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr = [NSMutableArray arrayWithArray:@[@"a1",@"a2",@"a3",@"a4"]];
    }
    return _imageArr;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"region_id", nil];
    }
    return _parameter;
}
#pragma mark >>>> 生命周期
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllerStatu = BHJViewControllerStatuIndiana;
    
    [self setNavgationBarView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    [self getData];
    [self setView];
}
#pragma mark >>>> 自定义
// 搜索
-(void)searchAction:(UIBarButtonItem *)sender{
    
    BHJSearchViewController *searchVC = [[BHJSearchViewController alloc]init];
    searchVC.viewControllerStatu = BHJViewControllerStatuIndiana;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)setView{
    
    self.navigationItem.title = @"夺宝岛";
    self.indianaCollectionView.backgroundColor = HWColor(239, 239, 239, 1.0);
    
    [self.view addSubview:self.indianaCollectionView];
    
    [self.indianaCollectionView registerNib:[UINib nibWithNibName:@"homeCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
    [self.indianaCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.indianaCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.indianaCollectionView registerNib:[UINib nibWithNibName:@"indianaCell" bundle:nil] forCellWithReuseIdentifier:@"indianaCell"];
    [self.indianaCollectionView registerNib:[UINib nibWithNibName:@"indianaCell_1" bundle:nil] forCellWithReuseIdentifier:@"indianaCell_1"];
}

-(void)getData{
    
    NSMutableArray *firstArr = [NSMutableArray arrayWithArray:@[@"home_1",@"home_2",@"home_3",@"home_4",@"home_5",@"home_6",@"home_7",@"home_8"]];
    NSMutableArray *themeArr = [NSMutableArray arrayWithArray:@[@"开饭啦",@"乐翻天",@"充值",@"签到有礼",@"餐饮",@"娱乐",@"生活",@"更多"]];
    [self.indianaData setObject:themeArr forKey:@"theme"];
    [self.indianaData setObject:firstArr forKey:@"section_1"];
    
    NSMutableArray *secondArr = [NSMutableArray arrayWithArray:@[@"store_image",@"banner_2"]];
    [self.indianaData setObject:secondArr forKey:@"section_2"];
    NSMutableArray *timeArr = [NSMutableArray arrayWithArray:@[@"12:00",@"14:00",@"16:00",@"19:00",@"21:00"]];
    [self.indianaData setObject:timeArr forKey:@"time"];
    //请求数据
    [self getIndianaDataWithUrl:IndianaUrl parameter:nil];
    [self getIndianaHotDataWithUrl:kIndianaHot parameter:nil];
    // 轮播图
    NSString *str = [BannerUrl stringByAppendingString:@"1"];
    [self getIndianaBannerWith:str parameter:nil];
}

-(void)selectedCity:(NSNotification *)sender{
    
    NSString *currentCity = sender.userInfo[@"userCity"];
    if (currentCity.length > 0) {
        [self.locationBtn setTitle:currentCity forState:UIControlStateNormal];
    }
}

#pragma mark >>>> 网络获取数据
-(void)getIndianaBannerWith:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfo:url parameters:parameter success:^(id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                Banner *banner = [Banner mj_objectWithKeyValues:dic];
                [data addObject:banner];
            }
        }
        [self.indianaData setObject:data forKey:@"banner"];
        [self.indianaCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

// 夺宝数据
-(void)getIndianaDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *dataSource = [NSMutableArray new];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            for (NSDictionary *dic in arr) {
                IndianaModel *model = [IndianaModel mj_objectWithKeyValues:dic];
                [dataSource addObject:model];
            }
        }
        [self.indianaData setObject:dataSource forKey:@"indiana"];
        [self.indianaCollectionView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

// 夺宝热门推荐数据
-(void)getIndianaHotDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *dataSource = [NSMutableArray new];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            for (NSDictionary *dic in arr) {
                IndianaModel *model = [IndianaModel mj_objectWithKeyValues:dic];
                [dataSource addObject:model];
            }
        }
        [self.indianaData setObject:dataSource forKey:@"Hot"];
        [self.indianaCollectionView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark >>>> UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0){
        return 8;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        NSArray *data = [self.indianaData objectForKey:@"Hot"];
        return data.count;
    }else{
        NSArray *data = [self.indianaData objectForKey:@"indiana"];
        return data.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        NSMutableArray *arr = [self.indianaData objectForKey:@"section_1"];
        homeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
        NSArray *themeArr = [self.indianaData objectForKey:@"theme"];
        cell.titleLabel.text = themeArr[indexPath.row];
        cell.markImage.image = [[UIImage imageNamed:arr[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [cell.markImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
        cell.markImage.contentMode =  UIViewContentModeScaleAspectFit;
        cell.markImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.markImage.clipsToBounds  = YES;
        return cell;
    }else if (indexPath.section == 1){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        NSMutableArray *arr = [self.indianaData objectForKey:@"section_2"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
        imageView.image = [[UIImage imageNamed:arr[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [cell addSubview:imageView];
        return cell;
    }else if (indexPath.section == 2){
        indianaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"indianaCell" forIndexPath:indexPath];
        NSArray *data = [self.indianaData objectForKey:@"Hot"];
        cell.model = data[indexPath.row];
        cell.delegate = self;
        //        cell.tryBtn.tag = 200;
        //        cell.buyBtn.tag = 201;
        cell.index = indexPath;
        if (indexPath.row == 0) {
            cell.title.text = @"这么精彩 超值实惠";
            cell.title.textColor = [UIColor colorWithHexString:@"#e4504b"];
        }
        return cell;
    }else {
        NSArray *data = [self.indianaData objectForKey:@"indiana"];
        indianaCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"indianaCell_1" forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = data[indexPath.row];
        cell.index = indexPath;
        cell.buyBtn.tag = 300;
        cell.tryBtn.tag = 301;
        return cell;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        return CGSizeMake((kScreenWidth - 35) / 4, kScreenHeight / 7);
    }else if (indexPath.section == 1){
        return CGSizeMake((kScreenWidth - 25) / 2, kScreenHeight / 7);
    }else if (indexPath.section == 3){
        return CGSizeMake(kScreenWidth, kScreenHeight / 5);
    }
    return CGSizeMake(kScreenWidth, kScreenHeight / 4);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        return UIEdgeInsetsMake(5, 10, 10, 10);
    }else if (section == 2){
        return UIEdgeInsetsMake(0, 0, 5, 0);
    }else if (section == 3){
        return UIEdgeInsetsMake(2, 0, 5, 0);
    }
    else{
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        for (UIView *view in headView.subviews) {
            [view removeFromSuperview];
        }
        if (indexPath.section == 0) {
            SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 4.73)];
            NSArray *banner = [self.indianaData objectForKey:@"banner"];
            NSMutableArray *images = [NSMutableArray new];
            for (Banner *model in banner) {
                [images addObject:model.image_url];
            }
            scrollView.imageURLStringsGroup = images;
            [headView addSubview:scrollView];
        }else if (indexPath.section == 2){
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(headView.frame) - 20, CGRectGetHeight(headView.frame) - 20)];
            titleLabel.text = @"热门推荐";
            [titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:18]];
            titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            UIView *markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
            markView.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
            markView.alpha = 0.5;
            [headView addSubview:markView];
            [headView addSubview:titleLabel];
        }
        return headView;
    }
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(kScreenWidth, kScreenHeight / 4.73);
    }else if (section == 2){
        return CGSizeMake(kScreenWidth - 20, kScreenHeight / 14.2);
    }else{
        return CGSizeMake(0, 0);
    }
}



-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 2) {
        return 10;
    }else if (section == 1){
        return 10;
    }else if (section == 3){
        return 2;
    }
    else{
        return 5;
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 2) {
        return 2;
    }else if (section == 1){
        return 5;
    }
    else{
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
            restaurantVC.viewStyle = ViewStleWithIndianaData;
            restaurantVC.class_id = 8;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 5){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.viewStyle = ViewStleWithIndianaData;
            restaurantVC.class_id = 9;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 6){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.viewStyle = ViewStleWithIndianaData;
            restaurantVC.class_id = 10;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else{
            MoreClassViewController *moreVC = [[MoreClassViewController alloc]init];
            [self.navigationController pushViewController:moreVC animated:YES];
        }
    }else if (indexPath.section == 2){
        NSArray *data = [self.indianaData objectForKey:@"Hot"];
        IndianaDetailViewController *detailVC = [[IndianaDetailViewController alloc]init];
        detailVC.model = data[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (indexPath.section == 3){
        IndianaDetailViewController *detailVC = [[IndianaDetailViewController alloc]init];
        NSArray *data = [self.indianaData objectForKey:@"indiana"];
        detailVC.model = data[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark >>> BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    //    switch (button.tag) {
    //        case 200:{
    //            IndianaDetailViewController *detailVC = [[IndianaDetailViewController alloc]init];
    //            [[BHJTools sharedTools]pushWithNavigationController:self.navigationController ViewController:detailVC];
    //        }
    //            break;
    //        case 201:{
    //            IndianaIslandViewController *isLandVC = [[IndianaIslandViewController alloc]init];
    //            [[BHJTools sharedTools]pushWithNavigationController:self.navigationController ViewController:isLandVC];
    //        }
    //            break;
    //        case 300:{
    //            IndianaDetailViewController *detailVC = [[IndianaDetailViewController alloc]init];
    //            [[BHJTools sharedTools]pushWithNavigationController:self.navigationController ViewController:detailVC];
    //            }
    //            break;
    //        case 301:{
    //            IndianaIslandViewController *isLandVC = [[IndianaIslandViewController alloc]init];
    //            [[BHJTools sharedTools]pushWithNavigationController:self.navigationController ViewController:isLandVC];
    //        }
    //            break;
    //
    //        default:
    //            break;
    //    }
}


@end
