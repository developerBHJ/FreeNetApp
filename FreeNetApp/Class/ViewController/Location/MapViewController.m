//
//  MapViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/2/11.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "MapViewController.h"
#import "CustomCalloutView.h"
#import "CustomAnnotationView.h"
#import "CommonUtility.h"
#import "StepDetailViewController.h"

#define  RoutePlanningPaddingEdge 20

@interface MapViewController ()<AMapSearchDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource,CustomAnnotationViewDelegate>

@property (nonatomic,strong)MAMapView *mapView;
@property (nonatomic,strong)AMapSearchAPI *searchAPI;
@property (nonatomic,assign)NSInteger poiCount;
@property (nonatomic,retain )AMapRoute *route;
@property (nonatomic,retain) NSArray *pathPolylines;
@property (nonatomic,retain)UITableView *tableView;

@end

@implementation MapViewController
#pragma mark - 懒加载
-(MAMapView *)mapView{
    
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView =[[ UITableView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        
    }
    return _tableView;
}


-(AMapSearchAPI *)searchAPI{

    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc]init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

-(NSArray *)mapData{

    if (!_mapData) {
        BHJStoreModel *model = [[BHJStoreModel alloc]initWithName:@"克拉拉牛排" address:@"陕西省西安市雁塔区高新路28号" logo:@"LOGO"];
        BHJStoreModel *model_1 = [[BHJStoreModel alloc]initWithName:@"肯德基" address:@"陕西省莲湖区" logo:@"LOGO"];
        BHJStoreModel *model_2 = [[BHJStoreModel alloc]initWithName:@"德克士" address:@"陕西省西安碑林区友谊东路" logo:@"LOGO"];
        _mapData = [NSArray arrayWithObjects:model,model_1,model_2, nil];
    }
    return _mapData;
}
#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userLocation = [[NSUserDefaults standardUserDefaults]objectForKey:@"userLocation"];
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    [self.view addSubview:self.mapView];
    
    self.poiCount = 0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 68;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    //    发起地理编码
    for (BHJStoreModel *model in self.mapData) {
        [self mapGeoCodeWithModel:model];
    }
}

#pragma mark - 自定义
//正向地理编码 //地名转经纬度
-(void)mapGeoCodeWithModel:(BHJStoreModel *)model{
    
    [AMapServices sharedServices].apiKey = mapKey;
    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = model.store_address;
    //发起正向地理编码
    [self.searchAPI AMapGeocodeSearch: geo];
}

//添加大头针
-(void)addAnnotationWithModel:(BHJStoreModel *)model addLocation:(AMapGeoPoint*)location{
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(location.latitude,location.longitude);
    pointAnnotation.title = model.store_name;
    pointAnnotation.subtitle = model.store_address;
    
    [_mapView addAnnotation:pointAnnotation];
}

#pragma mark - AMapSearchDelegate
//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if(response.geocodes.count == 0)
    {
        return;
    }
    for (AMapTip *tip in response.geocodes) {
        
        NSLog(@"formattedDescription---%@,latitude--%g,longitude---%g",tip.formattedDescription,tip.location.latitude,tip.location.longitude);
        [self addAnnotationWithModel:[self.mapData objectAtIndex:self.poiCount] addLocation:tip.location];
    }
    self.poiCount ++;
}
#pragma mark - MAMapViewDelegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //        NSLog(@"%f,%f,%@",userLocation.coordinate.latitude,userLocation.coordinate.longitude,userLocation.title);
        self.userLocation = userLocation;
        
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.radius = 10000;
        regeo.requireExtension = YES;
        //发起逆地理编码
        [self.searchAPI AMapReGoecodeSearch: regeo];
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        //        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        //        NSLog(@"ReGeo: %@", result);
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        annotationView.delegate = self;
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            annotationView.delegate =self;
        }
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
        return;
    }
    //通过AMapNavigationSearchResponse对象处理搜索结果
    //    NSString *route = [NSString stringWithFormat:@"Navi: %@", response.route];
    //
    //    AMapPath *path = response.route.paths[0]; //选择一条路径
    //    AMapStep *step = path.steps[0]; //这个路径上的导航路段数组
    //    NSLog(@"%@",step.polyline);   //此路段坐标点字符串
    //    NSLog(@"%@",response.route);
    self.route = response.route;
    [self.tableView reloadData];
    if (response.count > 0)
    {
        //移除地图原本的遮盖
        [_mapView removeOverlays:_pathPolylines];
        _pathPolylines = nil;
        
        // 只显⽰示第⼀条 规划的路径
        _pathPolylines = [self polylinesForPath:response.route.paths[0]];
        //        NSLog(@"%@",response.route.paths[0]);
        //添加新的遮盖，然后会触发代理方法进行绘制
        [_mapView addOverlays:_pathPolylines];
    }
    [UIView animateWithDuration:2 animations:^{
        self.mapView.frame =CGRectMake(0, 64, kScreenWidth, kScreenHeight / 2);
        self.tableView.frame =CGRectMake(0, self.mapView.bottom, kScreenWidth, kScreenHeight / 2 - 64);
    } completion:^(BOOL finished) {
        /* 缩放地图使其适应polylines的展示. */
        [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:_pathPolylines]
                            edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                               animated:YES];
    }];
}

//绘制遮盖时执行的代理方法
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    
    //画路线
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        //初始化一个路线类型的view
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        //设置线宽颜色等
        polygonView.lineWidth = 8.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
        polygonView.lineJoinType =kCGLineJoinMiter;//线的类型
        return polygonView;
    }
    return nil;
}

//路线解析
- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}

//解析经纬度
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    
    return coordinates;
}

//当选中大头针是触发的代理
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
    //   取得选中大头针的坐标
    CLLocationCoordinate2D  cllocat = view.annotation.coordinate;
    NSLog(@"%f,%f",cllocat.latitude,cllocat.longitude);
    [self mapRouteSearchWiwhDestination:cllocat];
}

#pragma mark - 发起路径规划
//驾车路径查询
-(void)mapRouteSearchWiwhDestination:(CLLocationCoordinate2D )destination{
    //构造AMapDrivingRouteSearchRequest对象，设置驾车路径规划请求参数
    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
    request.origin = [AMapGeoPoint locationWithLatitude:_userLocation.coordinate.latitude longitude:_userLocation.coordinate.longitude];
    request.destination = [AMapGeoPoint locationWithLatitude:destination.latitude longitude:destination.longitude];
    //发起路径搜索
    [_searchAPI AMapDrivingRouteSearch: request];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    AMapPath *path = self.route.paths[0];
    return path.steps.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AMapPath *path = self.route.paths[0];
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    cell.textLabel.text =[path.steps[indexPath.row] instruction];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    AMapPath *path = self.route.paths[0];
    NSString *str = [path.steps[indexPath.row] instruction];
    CGFloat contentH = [str heightWithWidth:self.tableView.width font:17];
    return contentH;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        StepDetailViewController *stepDetailViewController = [[StepDetailViewController alloc] init];
        AMapPath *path =self.route.paths[0];
    
        stepDetailViewController.step =path.steps[indexPath.row];
    
        [self.navigationController pushViewController:stepDetailViewController animated:YES];
}


-(void)findRoudWintAdress:(NSString *)adress{
    
    
    
}


@end
