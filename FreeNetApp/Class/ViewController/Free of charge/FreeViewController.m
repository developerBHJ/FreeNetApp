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
#define TimeUrl @"http://192.168.0.254:4004/free/data_times"
#define kTimeList @"http://192.168.0.254:4004/free/free_times"

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
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"region_id", nil];
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
    
    self.homeCollectionView.backgroundColor = HWColor(239, 239, 239, 1.0);
    [self.view addSubview:self.homeCollectionView];
    
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
    //热门推荐
    [self getHotRecommendDataWithUrl:HotUrl parameter:self.parameter];
    // 轮播图
    NSString *str = [BannerUrl stringByAppendingString:@"1"];
    [self getHomeBannerWith:str parameter:nil];
    
    // 获取时间列表
    [self getTimeListWith:kTimeList paramater:self.parameter];
    //整点开抢
    [self getTimeDataWithUrl:TimeUrl parameter:self.parameter];
}

// 整点开抢
-(void)striveTime:(UIButton *)sender{
    
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
    
    [self.homeViewData removeObjectForKey:@"Time"];
    NSArray *timeArr = [self.homeViewData objectForKey:@"time"];
    [self.parameter setValue:timeArr[sender.tag - 1000] forKey:@"times"];
    [self getTimeDataWithUrl:TimeUrl parameter:self.parameter];
}



/**
 没数据的时候点击跳转
 
 @param sender 按钮
 */
-(void)jumpAction:(UIButton *)sender{
    
    [self getData];
}

/**
 选择城市
 
 @param sender 按钮
 */
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


/**
 时间选择头视图上添加按钮
 
 @param view 头视图
 @param timeArray 时间列表
 */
-(void)addButtonOnView:(UIView *)view array:(NSArray *)timeArray{
    
    UIView *markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    markView.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
    markView.alpha = 0.5;
    [view addSubview:markView];
    self.bubbleView = [[arrowView alloc]initWithFrame:CGRectMake(0,0, 16, 0)];
    [view addSubview:self.bubbleView];
    NSMutableArray *time = [NSMutableArray new];
    for (NSString *str in timeArray) {
        NSString *subtime = [str substringToIndex:5];
        [time addObject:subtime];
    }
    for (int i = 0; i < time.count; i ++) {
        UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [timeBtn setTitle:time[i] forState:UIControlStateNormal];
        CGFloat btnWidth = kScreenWidth / 5;
        [timeBtn setFrame:CGRectMake(btnWidth * i, 10, btnWidth, 39)];
        [timeBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [timeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [timeBtn addTarget:self action:@selector(striveTime:) forControlEvents:UIControlEventTouchUpInside];
        timeBtn.tag = 1000 + i;
        [view addSubview:timeBtn];
        if (i == 0) {
            [self selectedButton:timeBtn];
        }
    }
}


/**
 根据数据源加载页面
 
 @param data 数据源
 @return 数据源中数据个数
 */
-(void)showSubViewsWithData:(NSArray *)data{
    
    if (data.count == 0) {
        self.homeCollectionView.hidden = YES;
        [self setViewWithNothingWithImageName:@"Wifi" alerntTitle:@"没有连接至网络" buttonTitle:@"重新加载" subContent:@"请打开网络连接开关后重试" selector:@selector(jumpAction:) imageFrame:CGRectMake(kScreenWidth / 2.75, kScreenHeight / 3, kScreenWidth / 3.5, kScreenWidth  / 4)];
    }else{
        for (UIView *subView in self.view.subviews) {
            [subView removeFromSuperview];
        }
        self.homeCollectionView.hidden = NO;
        self.homeCollectionView.backgroundColor = HWColor(239, 239, 239, 1.0);
        [self.view addSubview:self.homeCollectionView];
    }
}
#pragma mark >>>> 网络获取数据
-(void)getHomeBannerWith:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    WeakSelf(weakself);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfo:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"];
        NSLog(@"%@",array);
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                Banner *banner = [Banner mj_objectWithKeyValues:dic];
                [data addObject:banner];
            }
        }
        [weakself.homeViewData setObject:data forKey:@"banner"];
        [weakself.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

// 热门推荐数据
-(void)getHotRecommendDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    WeakSelf(weakself);
    NSMutableArray *data = [NSMutableArray new];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                HotRecommend *hot = [HotRecommend mj_objectWithKeyValues:dic];
                NSLog(@"time = %@",dic[@"start_time"]);
                NSLog(@"class = %@",[dic[@"start_time"] class]);
                [data addObject:hot];
            }
            [weakself.homeViewData setObject:data forKey:@"hot"];
            [weakself.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

// 整点抢数据
-(void)getTimeDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    WeakSelf(weakself);
    NSLog(@"%@",parameter);
    NSMutableArray *data = [NSMutableArray new];
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                HotRecommend *hot = [HotRecommend mj_objectWithKeyValues:dic];
                [data addObject:hot];
            }
        }
        [weakself.homeViewData setObject:data forKey:@"Time"];
        [weakself.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:3]];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取时间列表
 
 @param url 时间段URL
 @param paramater 参数
 */
-(void)getTimeListWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weakself);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
        if (data.count > 0) {
            NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
            NSWidthInsensitiveSearch|NSForcedOrderingSearch;
            NSComparator sort = ^(NSString *obj1,NSString *obj2){
                NSRange range = NSMakeRange(0,obj1.length);
                return [obj1 compare:obj2 options:comparisonOptions range:range];
            };
            NSArray *resultArray = [data sortedArrayUsingComparator:sort];
            // NSLog(@"%@",resultArray);
            [weakself.homeViewData setObject:resultArray forKey:@"time"];
        }
        [weakself.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
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
        NSArray *dataArr = [self.homeViewData objectForKey:@"hot"];
        [self showSubViewsWithData:dataArr];
        return dataArr.count;
    }else if (section == 3){
        NSArray *dataArr = [self.homeViewData objectForKey:@"Time"];
        return dataArr.count;
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
        homeCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell_1" forIndexPath:indexPath];
        cell.delegate = self;
        cell.striveBtn.tag = 200;
        cell.index = indexPath;
        NSArray *dataArr = [self.homeViewData objectForKey:@"hot"];
        HotRecommend *model = dataArr[indexPath.row];
        cell.model = model;
        return cell;
    }else if(indexPath.section == 3){
        homeCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell_2" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        cell.striveBtn.tag = 201;
        NSArray *dataArr = [self.homeViewData objectForKey:@"Time"];
        HotRecommend *model = dataArr[indexPath.row];
        cell.model = model;
        return cell;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        return CGSizeMake((kScreenWidth - 35) / 4, 82);
    }else if (indexPath.section == 3){
        return CGSizeMake(kScreenWidth, 114);
    }else if (indexPath.section == 2){
        return CGSizeMake(kScreenWidth, 0);
    }
    return CGSizeMake(kScreenWidth, 126);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 1){
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }else if (section == 3){
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }else if (section == 2){
        return UIEdgeInsetsMake(0, 0, 0, 0);
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
            NSArray *banner = [self.homeViewData objectForKey:@"banner"];
            NSMutableArray *images = [NSMutableArray new];
            for (Banner *model in banner) {
                [images addObject:model.image_url];
            }
            scrollView.imageURLStringsGroup = images;
            [headView addSubview:scrollView];
        }else if (indexPath.section == 1){
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(headView.frame) - 20, CGRectGetHeight(headView.frame) - 20)];
            titleLabel.text = @"热门推荐";
            headView.backgroundColor = [UIColor whiteColor];
            [titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:18]];
            titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            [headView addSubview:titleLabel];
        }else if (indexPath.section == 2){
            NSArray *timeArr = [self.homeViewData objectForKey:@"time"];
            [self addButtonOnView:headView array:timeArr];
        }
        return headView;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        homeFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeFooterView" forIndexPath:indexPath];
        footerView.allBtn.tag = 500;
        footerView.delegate = self;
        footerView.viewController = self;
        footerView.indexPath = indexPath;
        if (indexPath.section == 3) {
            return footerView;
        }
    }
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 120);
    }else if (section == 1){
        return CGSizeMake(kScreenWidth - 20, 40);
    }else if (section == 2){
        return CGSizeMake(kScreenWidth - 20, 50);
    }else{
        return CGSizeMake(0, 0);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 3) {
        return CGSizeMake(kScreenWidth, 38);
    }else{
        return CGSizeMake(0, 0);
    }
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
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
            restaurantVC.viewStyle = ViewStleWithFreeData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 5){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.type = @(2);
            restaurantVC.viewStyle = ViewStleWithFreeData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else if (indexPath.row == 6){
            RestaurantViewController *restaurantVC = [[RestaurantViewController alloc]init];
            restaurantVC.type = @(3);
            restaurantVC.viewStyle = ViewStleWithFreeData;
            [self.navigationController pushViewController:restaurantVC animated:YES];
        }else{
            MoreClassViewController *moreVC = [[MoreClassViewController alloc]init];
            [self.navigationController pushViewController:moreVC animated:YES];
        }
    }else if (indexPath.section == 1){
        NSArray *dataArr = [self.homeViewData objectForKey:@"hot"];
        HotRecommend *model = dataArr[indexPath.row];
        BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
        berserkVC.model = model;
        [self.navigationController pushViewController:berserkVC animated:YES];
    }else if (indexPath.section == 3){
        NSArray *dataArr = [self.homeViewData objectForKey:@"Time"];
        HotRecommend *model = dataArr[indexPath.row];
        BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
        berserkVC.model = model;
        [self.navigationController pushViewController:berserkVC animated:YES];
    }
    
}

#pragma mark >>> BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    NSArray *dataArr = [self.homeViewData objectForKey:@"hot"];
    HotRecommend *model = dataArr[index.row];
    BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
    berserkVC.model = model;
    [self.navigationController pushViewController:berserkVC animated:YES];
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
