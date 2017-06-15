//
//  FreeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "FreeViewController.h"
#import "homeCell.h"
#import "homeCell_1.h"
#import "homeCell_2.h"
#import "homeFooterView.h"
#import "HotRecommend.h"
#import "Banner.h"
#import "ClassModel.h"
#define HotUrl @"http://192.168.0.254:4004/free/sfplans"
#define TimeUrl @"http://192.168.0.254:1000/free/timecates"
#define ClassUrl @"http://192.168.0.254:1000/personer/class"

@interface FreeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate,BHJReusableViewDelegate>

@property (nonatomic,strong)UICollectionView *homeCollectionView;
@property (nonatomic,strong)NSMutableDictionary *homeViewData;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)UIButton *selectedBtn;
@property (nonatomic,strong)arrowView *bubbleView;
@property (nonatomic,strong)NSMutableDictionary *parameter;

@end

@implementation FreeViewController
#pragma mark >>>> 懒加载
-(UICollectionView *)homeCollectionView{
    
    if (!_homeCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _homeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _homeCollectionView.delegate = self;
        _homeCollectionView.dataSource = self;
        _homeCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _homeCollectionView;
}

-(NSMutableDictionary *)homeViewData{
    
    if (!_homeViewData) {
        _homeViewData = [NSMutableDictionary new];
    }
    return _homeViewData;
}

-(NSMutableArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr = [NSMutableArray arrayWithArray:@[@"a1",@"a2",@"a3",@"a4"]];
    }
    return _imageArr;
}


-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2822",@"region_id",@"1",@"page",@"1",@"type", nil];
    }
    return _parameter;
}

#pragma mark >>>> 生命周期
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedCity:) name:@"selectedCity" object:nil];
    [self setNavgationBarView];
    [self getData];
    [self setView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
}

#pragma mark >>>> 自定义
// 搜索
-(void)searchAction:(UIBarButtonItem *)sender{
    
    BHJSearchViewController *searchVC = [[BHJSearchViewController alloc]init];
    searchVC.viewControllerStatu = BHJViewControllerStatuFree;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)setView{
    
    self.navigationItem.title = @"免费";
    if (self.homeViewData.count == 0) {
        [self setViewWithNothingWithImageName:@"Wifi" alerntTitle:@"没有连接至网络" buttonTitle:@"重新加载" subContent:@"请打开网络连接开关后重试" selector:@selector(jumpAction:) imageFrame:CGRectMake(kScreenWidth / 2.75, kScreenHeight / 3, kScreenWidth / 3.5, kScreenWidth  / 4)];
    }else{
        self.homeCollectionView.backgroundColor = HWColor(239, 239, 239, 1.0);
        [self.view addSubview:self.homeCollectionView];
    }
    
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"homeCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
    [self.homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"homeCell_1" bundle:nil] forCellWithReuseIdentifier:@"homeCell_1"];
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"homeCell_2" bundle:nil] forCellWithReuseIdentifier:@"homeCell_2"];
    
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"homeFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeFooterView"];
    
}


-(void)getData{
    
    NSMutableArray *firstArr = [NSMutableArray arrayWithArray:@[@"home_1",@"home_2",@"home_3",@"home_4",@"home_5",@"home_6",@"home_7",@"home_8"]];
    NSMutableArray *themeArr = [NSMutableArray arrayWithArray:@[@"开饭啦",@"乐翻天",@"充值",@"签到有礼",@"餐饮",@"娱乐",@"生活",@"更多"]];
    [self.homeViewData setObject:themeArr forKey:@"theme"];
    [self.homeViewData setObject:firstArr forKey:@"section_1"];
    
    NSMutableArray *secondArr = [NSMutableArray arrayWithArray:@[@"store_image",@"banner_2"]];
    [self.homeViewData setObject:secondArr forKey:@"section_2"];
    NSMutableArray *timeArr = [NSMutableArray arrayWithArray:@[@"12:00",@"14:00",@"16:00",@"19:00",@"21:00"]];
    [self.homeViewData setObject:timeArr forKey:@"time"];
    // 分类
    [self getClassDataWith:ClassUrl parameter:nil];
    //热门推荐
  //  [self getHotRecommendDataWithUrl:HotUrl parameter:self.parameter];
    //整点开抢
    [self getTimeDataWithUrl:TimeUrl parameter:self.parameter];
    // 轮播图
    [self.parameter setValue:@"1" forKey:@"type"];
    [self getHomeBannerWith:BannerUrl parameter:self.parameter];
}

// 整点开抢
-(void)striveTime:(UIButton *)sender{
    
    switch (sender.tag) {
        case 1000:{
            [self.parameter setValue:@"1" forKey:@"type"];
        }
            break;
        case 1001:{
            [self.parameter setValue:@"2" forKey:@"type"];
        }
            break;
        case 1002:{
            [self.parameter setValue:@"3" forKey:@"type"];
        }
            break;
        case 1003:{
            [self.parameter setValue:@"4" forKey:@"type"];
        }
            break;
        case 1004:{
            [self.parameter setValue:@"5" forKey:@"type"];
        }
            break;
        default:
            break;
    }
    [self getTimeDataWithUrl:TimeUrl parameter:self.parameter];
    [self selectedButton:sender];
}

-(void)selectedButton:(UIButton *)sender{
    
    self.selectedBtn.enabled = YES;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor colorWithHexString:@"e4504b"]];
    [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [sender.titleLabel setFont:[UIFont systemFontOfSize:22]];
    self.bubbleView.fillColor = [UIColor colorWithHexString:@"#e4504b"];
    self.bubbleView.strokeColor = [UIColor colorWithHexString:@"#e4504b"];
    self.bubbleView.frame = CGRectMake(sender.centerX - 8, sender.bottom - 1, 16, 16);
    [self.selectedBtn setBackgroundColor:[UIColor clearColor]];
    [self.selectedBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.selectedBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.selectedBtn = sender;
    sender.enabled = NO;
}


-(void)jumpAction:(UIButton *)sender{
    
    NSLog(@"重新加载数据");
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
    [self getHotRecommendDataWithUrl:HotUrl parameter:self.parameter];
    [self getTimeDataWithUrl:TimeUrl parameter:self.parameter];
}
#pragma mark >>>> 网络获取数据
-(void)getHomeBannerWith:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                Banner *banner = [Banner mj_objectWithKeyValues:dic];
                [data addObject:banner];
            }
        }
        [self.homeViewData setObject:data forKey:@"banner"];
        [self.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

// 分类数据
-(void)getClassDataWith:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in array) {
            ClassModel *model = [ClassModel mj_objectWithKeyValues:dic];
            [data addObject:model];
            NSLog(@"%d===%@",model.id,model.name);
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:GETCLASSLIST object:nil userInfo:@{@"class":data}];
        [self.homeViewData setObject:data forKey:@"class"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

// 热门推荐数据
-(void)getHotRecommendDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                HotRecommend *hot = [HotRecommend mj_objectWithKeyValues:dic];
                [data addObject:hot];
            }
        }
        NSLog(@"----------------%@",array);
        [self.homeViewData setObject:data forKey:@"hot"];
        [self.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
        NSLog(@"请求数据成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

// 整点抢数据
-(void)getTimeDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                HotRecommend *hot = [HotRecommend mj_objectWithKeyValues:dic];
                [data addObject:hot];
            }
        }
        [self.homeViewData setObject:data forKey:@"Time"];
        [self.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:4]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

#pragma mark >>>> UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0){
        return 8;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
       // NSArray *dataArr = [self.homeViewData objectForKey:@"hot"];
        return 3;
    }else if (section == 4){
       // NSArray *dataArr = [self.homeViewData objectForKey:@"Time"];
        return 5;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        NSMutableArray *arr = [self.homeViewData objectForKey:@"section_1"];
        NSArray *themeArr = [self.homeViewData objectForKey:@"theme"];
        homeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
        cell.titleLabel.text = themeArr[indexPath.row];
        cell.markImage.image = [[UIImage imageNamed:arr[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [cell.markImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
        cell.markImage.contentMode =  UIViewContentModeScaleAspectFit;
        cell.markImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.markImage.clipsToBounds  = YES;
        return cell;
    }else if (indexPath.section == 1){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        NSMutableArray *arr = [self.homeViewData objectForKey:@"section_2"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
        imageView.image = [[UIImage imageNamed:arr[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [cell addSubview:imageView];
        return cell;
    }else if (indexPath.section == 2){
        homeCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell_1" forIndexPath:indexPath];
        cell.delegate = self;
        cell.striveBtn.tag = 200;
        cell.index = indexPath;
        NSArray *dataArr = [self.homeViewData objectForKey:@"hot"];
        HotRecommend *model = dataArr[indexPath.row];
      //  cell.model = model;
        return cell;
    }else if(indexPath.section == 4){
        homeCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell_2" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        cell.striveBtn.tag = 201;
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm:ss"];
        NSString *hourMinuteSecond = [dateFormatter stringFromDate:date];
        cell.time_h1.text = [hourMinuteSecond substringWithRange:NSMakeRange(0, 1)];
        cell.time_h2.text = [hourMinuteSecond substringWithRange:NSMakeRange(1, 1)];
        cell.time_m1.text = [hourMinuteSecond substringWithRange:NSMakeRange(3, 1)];
        cell.time_m2.text = [hourMinuteSecond substringWithRange:NSMakeRange(4, 1)];
        cell.time_s1.text = [hourMinuteSecond substringWithRange:NSMakeRange(6, 1)];
        cell.time_s2.text = [hourMinuteSecond substringWithRange:NSMakeRange(7, 1)];
        NSArray *dataArr = [self.homeViewData objectForKey:@"Time"];
        HotRecommend *model = dataArr[indexPath.row];
       // cell.model = model;
        return cell;
    }
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        return CGSizeMake((kScreenWidth - 35) / 4, kScreenHeight / 7);
    }else if (indexPath.section == 1){
        return CGSizeMake((kScreenWidth - 25) / 2, kScreenHeight / 7);
    }else if (indexPath.section == 4){
        return CGSizeMake(kScreenWidth, kScreenHeight / 5);
    }else if (indexPath.section == 3){
        return CGSizeMake(kScreenWidth, 0);
    }
    return CGSizeMake(kScreenWidth, kScreenHeight / 4.5);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        return UIEdgeInsetsMake(5, 10, 10, 10);
    }else if (section == 2){
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }else if (section == 4){
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }else if (section == 3){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
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
            NSArray *banner = [self.homeViewData objectForKey:@"banner"];
            NSMutableArray *images = [NSMutableArray new];
            for (Banner *model in banner) {
                [images addObject:model.content];
            }
            // scrollView.imageURLStringsGroup = images;
            scrollView.localizationImageNamesGroup = self.imageArr;
            [headView addSubview:scrollView];
        }else if (indexPath.section == 2){
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(headView.frame) - 20, CGRectGetHeight(headView.frame) - 20)];
            titleLabel.text = @"热门推荐";
            headView.backgroundColor = [UIColor whiteColor];
            [titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:18]];
            titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            [headView addSubview:titleLabel];
        }else if (indexPath.section == 3){
            NSArray *timeArr = [self.homeViewData objectForKey:@"time"];
            UIView *markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
            markView.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
            markView.alpha = 0.5;
            [headView addSubview:markView];
            self.bubbleView = [[arrowView alloc]initWithFrame:CGRectMake(0,0, 16, 0)];
            [headView addSubview:self.bubbleView];
            for (int i = 0; i < 5; i ++) {
                UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [timeBtn setTitle:timeArr[i] forState:UIControlStateNormal];
                CGFloat btnWidth = kScreenWidth / 5;
                [timeBtn setFrame:CGRectMake(btnWidth * i, 10, btnWidth, kScreenHeight / 14.2 - 1)];
                [timeBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
                [timeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
                [timeBtn addTarget:self action:@selector(striveTime:) forControlEvents:UIControlEventTouchUpInside];
                timeBtn.tag = 1000 + i;
                [headView addSubview:timeBtn];
                if (i == 1) {
                    [self selectedButton:timeBtn];
                }
            }
        }
        return headView;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        homeFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeFooterView" forIndexPath:indexPath];
        footerView.allBtn.tag = 500;
        footerView.delegate = self;
        footerView.viewController = self;
        footerView.indexPath = indexPath;
        if (indexPath.section == 4) {
            return footerView;
        }
    }
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(kScreenWidth, kScreenHeight / 4.73);
    }else if (section == 2){
        return CGSizeMake(kScreenWidth - 20, kScreenHeight / 14.2);
    }else if (section == 3){
        return CGSizeMake(kScreenWidth - 20, kScreenHeight / 11.2);
    }
    else{
        return CGSizeMake(0, 0);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 4) {
        return CGSizeMake(kScreenWidth, kScreenHeight / 15);
    }else{
        return CGSizeMake(0, 0);
    }
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 2 || section == 4) {
        return 2;
    }else if (section == 1){
        return 10;
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
            restaurantVC.class_id = 8;
            restaurantVC.viewStyle = ViewStleWithFreeData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 5){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.class_id = 9;
            restaurantVC.viewStyle = ViewStleWithFreeData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 6){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.class_id = 10;
            restaurantVC.viewStyle = ViewStleWithFreeData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else{
            MoreClassViewController *moreVC = [[MoreClassViewController alloc]init];
            [self.navigationController pushViewController:moreVC animated:YES];
        }
    }else if (indexPath.section == 2){
        NSArray *dataArr = [self.homeViewData objectForKey:@"hot"];
        HotRecommend *model = dataArr[indexPath.row];
        BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
        berserkVC.detailModel = model;
        [self.navigationController pushViewController:berserkVC animated:YES];
    }else if (indexPath.section == 4){
        NSArray *dataArr = [self.homeViewData objectForKey:@"Time"];
        HotRecommend *model = dataArr[indexPath.row];
        BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
        berserkVC.detailModel = model;
        [self.navigationController pushViewController:berserkVC animated:YES];
    }
    
}

#pragma mark >>> BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    //    if (button.tag == 200) {
    //        NSLog(@"cellRow:%ld tag:%ld",cellRow,button.tag);
    //    }else{
    BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
    [self.navigationController pushViewController:berserkVC animated:YES];
    //    }
}

#pragma mark >>> BHJReusableViewDelegate
-(void)BHJReusableViewDelegateMethodWithIndexPath:(NSIndexPath *)indexPath button:(UIButton *)button{
    
    switch (button.tag) {
        case 500:{
            NSLog(@"查看全部");
        }
            break;
        case 501:{
            PersonalTagViewController *tagVC = [[PersonalTagViewController alloc]init];
            [self.navigationController pushViewController:tagVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
