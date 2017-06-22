//
//  BHJViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJViewController.h"
#import "LocationViewController.h"
#import "BHJSearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"

@interface BHJViewController ()<ChooseCityDelegate,UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)NSMutableDictionary *parameter;
@property (nonatomic,strong)NSMutableDictionary *areaData;
@property (nonatomic,strong)NSMutableDictionary *street;

@end

@implementation BHJViewController
#pragma mark - 懒加载
-(UISearchBar *)searchBar{
    
    if (!_searchBar) {
        CGFloat barwidth = kScreenWidth / 3 * 2;
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(self.view.centerX - barwidth / 2, 12, barwidth, 20)];
        _searchBar.placeholder = @"请输入关键字";
        _searchBar.delegate = self;
    }
    return _searchBar;
}


-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary new];
    }
    return _parameter;
}

-(NSMutableDictionary *)areaData{
    
    if (!_areaData) {
        _areaData = [NSMutableDictionary new];
    }
    return _areaData;
}

-(NSMutableDictionary *)street{

    if (!_street) {
        _street = [NSMutableDictionary new];
    }
    return _street;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取区域数据
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       // [self settleAreaData];
    });
    //    UIToolbar *statusBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    //    statusBar.backgroundColor = [UIColor blackColor];
    //    [self.view addSubview:statusBar];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.navigationItem.title = self.navgationTitle;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.searchBar = nil;
    [self getLocationData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationCity:) name:GETLOCATIONNOTIFICATION object:nil ];
}

-(void)getLocationCity:(NSNotification *)sender{
    
    NSString *currentCity = sender.userInfo[@"userCity"];
    if (currentCity.length > 0) {
        [self.locationBtn setTitle:currentCity forState:UIControlStateNormal];
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:GETLOCATIONNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectedCity" object:nil];
}

#pragma mark - Method
// 获取位置信息
-(void)getLocationData{
    //判断定位操作是否被允许
    
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init] ;
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
        if (IOS8) {
            //使用应用程序期间允许访问位置数据
            [self.locationManager requestWhenInUseAuthorization];
        }
        // 开始定位
        [self.locationManager startUpdatingLocation];
    }else {
        //提示用户无法进行定位操作
        NSLog(@"%@",@"定位服务当前可能尚未打开，请设置打开！");
    }
}


// back
- (void)back:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 无数据，空页面
-(void)setViewWithNothingWithImageName:(NSString *)image alerntTitle:(NSString *)title buttonTitle:(NSString *)str subContent:(NSString *)content selector:(SEL)selector imageFrame:(CGRect)frame{
    
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    UIImageView *notingImage = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    notingImage.frame = frame;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(notingImage.frame) + 10, kScreenWidth - 20, 21)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [self.view addSubview:notingImage];
    if (content != nil) {
        UILabel *subTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 10, kScreenWidth - 20, 21)];
        subTitle.text = content;
        subTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:subTitle];
        subTitle.textColor = [UIColor colorWithHexString:@"#bebebe"];
        UIButton *jumpAction = [UIButton buttonWithType:UIButtonTypeSystem];
        [jumpAction setFrame:CGRectMake(kScreenWidth / 2.5, CGRectGetMaxY(subTitle.frame) + 15, kScreenWidth / 4, 35)];
        [jumpAction setTitle:str forState:UIControlStateNormal];
        [jumpAction setBackgroundColor:[UIColor colorWithHexString:@"#e4504b"]];
        jumpAction.cornerRadius = 5;
        [jumpAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jumpAction addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:jumpAction];
    }
}

// 设置导航栏
-(void)setNavgationBarView{
    
    if (self.leftImage) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:self.leftImage] style:UIBarButtonItemStylePlain target:self action:@selector(modifyLocation:)];
    }else{
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 25)];
        self.locationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.locationBtn setTitle:@"北京市" forState:UIControlStateNormal];
        [self.locationBtn setFrame:CGRectMake(0, 0, 60, 25)];
        [self.locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.locationBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.locationBtn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:self.locationBtn];
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 10, 5)];
        rightImage.image = [[UIImage imageNamed:@"下拉-ico"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
        [leftView addSubview:rightImage];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    if (self.leftBtnTitle_1) {
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:self.leftBtnTitle_1] style:UIBarButtonItemStylePlain target:self action:@selector(modifyLocation:)];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        self.navigationItem.leftBarButtonItems = @[backItem,leftBarButtonItem];
    }
}

// 定位
-(void)location:(UIButton *)sender{
    
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    [locationVC setDelegate:self];
    [self.navigationController pushViewController:locationVC animated:YES];
}

// 地图定位
-(void)modifyLocation:(UIBarButtonItem *)sender{
    
    MapViewController *mapVC = [[MapViewController alloc]init];
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(LocationViewController *)chooseCityController didSelectCity:(GYZCity *)city
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(LocationViewController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - CoreLocation Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count >0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
             NSString *currCity = placemark.locality;
             // NSString *p = placemark.administrativeArea;
             if (!currCity) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 currCity = placemark.administrativeArea;
             }
             NSString *address = [placemark.subLocality stringByAppendingString:placemark.thoroughfare];
             [[NSNotificationCenter defaultCenter]postNotificationName:GETLOCATIONNOTIFICATION object:nil userInfo:@{@"userCity":currCity,@"userLocation":currentLocation,@"user_address":address}];
         } else if (error ==nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error !=nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
         
     }];
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code ==kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}
#pragma mark - 网络请求
// 获取省份数据
-(void)getProvinceData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://192.168.0.254:1000/index/provinces" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *p in dataArr) {
            NSMutableDictionary *province = [NSMutableDictionary new];
            [province setValue:p[@"id"] forKey:@"province_id"];
            [province setValue:p[@"name"] forKey:@"province_name"];
            [self.areaData setObject:province forKey:p[@"id"]];
            [self.parameter setValue:p[@"id"] forKey:@"province"];
            [self getCityDataWithUrl:@"http://192.168.0.254:1000/index/city" parameter:self.parameter];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

// 获取城市数据
-(void)getCityDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *area = [NSMutableArray new];
    NSString *key = [parameter valueForKey:@"province"];
    NSMutableDictionary *province = [self.areaData objectForKey:key];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *cities = [NSMutableArray new];
        if (dataArr.count > 0) {
            for (NSDictionary *city in dataArr) {
                NSMutableDictionary *cityDic = [NSMutableDictionary new];
                [cityDic setValue:city[@"id"] forKey:@"city_id"];
                [cityDic setValue:city[@"name"] forKey:@"city_name"];
                [cities addObject:cityDic];
                [self.parameter setValue:city[@"id"] forKey:@"cityId"];
                [self getAreaDataWithUrl:@"http://192.168.0.254:1000/index/area" parameter:self.parameter];
            }
            [province setObject:cities forKey:@"cities"];
        }
        NSArray *keys = [self.areaData allKeys];
        for (NSString *key in keys) {
            NSDictionary *province = [self.areaData objectForKey:key];
            [area addObject:province];
        }
       [[BHJTools sharedTools]saveDataToSandboxWith:area name:@"province.plist"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 获取区域信息
-(void)getAreaDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSString *key = [parameter valueForKey:@"cityId"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (dataArr.count > 0) {
            [self.street setObject:dataArr forKey:key];
        }
        [[BHJTools sharedTools]saveDataToSandboxWith:self.street name:@"street.plist"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)settleAreaData{
    
    [self getProvinceData];
    NSArray *area = [[BHJTools sharedTools]readNSArrayFromSandboxWithName:@"province.plist"];
    NSDictionary *street = [[BHJTools sharedTools]readNSDictionaryFromSandboxWithName:@"street.plist"];
    
    NSMutableArray *areaData = [NSMutableArray new];
    for (NSMutableDictionary *province in area) {
        NSArray *cities = [province objectForKey:@"cities"];
        NSMutableDictionary *pDic = [NSMutableDictionary new];
        [pDic setValue:province[@"province_id"] forKey:@"province_id"];
        [pDic setValue:province[@"province_name"] forKey:@"province_name"];
        NSMutableArray *cityArr = [NSMutableArray new];
        if (cities.count > 0) {
            for (NSDictionary *city in cities) {
                NSMutableDictionary *cDic = [NSMutableDictionary new];
                 [cDic setValue:city[@"city_id"] forKey:@"city_id"];
                [cDic setValue:city[@"city_name"] forKey:@"city_name"];
                NSString *pre = [city[@"city_name"] firstCharactor];
                [cDic setValue:pre forKey:@"initial"];
                NSArray *area = [street objectForKey:city[@"city_id"]];
                if (area.count > 0) {
                    [cDic setObject:area forKey:@"area"];
                }
                [cityArr addObject:cDic];
            }
            [pDic setObject:cityArr forKey:@"cities"];
        }
        [areaData addObject:pDic];
    }
    [[BHJTools sharedTools]saveDataToSandboxWith:areaData name:@"area.plist"];
    
    
    NSMutableArray *cityArray = [NSMutableArray new];
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    NSMutableArray *cityData = [NSMutableArray new];
    NSMutableArray *keys = [NSMutableArray new];
    for (NSDictionary *dic in array) {
        NSArray *cities = dic[@"cities"];
        for (NSDictionary *city in cities) {
            [cityData addObject:city];
            NSString *key = city[@"initial"];
            if (![keys containsObject:key]) {
                [keys addObject:key];
            }
        }
    }
    NSArray *array2 = [keys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in array2) {
        NSMutableDictionary *cityDic = [NSMutableDictionary new];
        [cityDic setObject:key forKey:@"key"];
        NSMutableArray *temp = [NSMutableArray new];
        for (NSDictionary *dic in cityData) {
            if ([key isEqualToString:dic[@"initial"]]) {
                [temp addObject:dic];
            }
        }
        [cityDic setObject:temp forKey:@"cities"];
        [cityArray addObject:cityDic];
    }
    [[BHJTools sharedTools]saveDataToSandboxWith:cityArray name:@"CityData.plist"];
}

@end
