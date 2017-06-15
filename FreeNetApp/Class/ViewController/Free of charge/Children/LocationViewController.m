//
//  LocationViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "LocationViewController.h"
#import "GYZCityGroupCell.h"
#import "GYZCityHeaderView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource,CityGroupCellDelegate,UISearchBarDelegate>

@property (nonatomic,strong)UITableView *locationView;

/**
 *  记录所有城市信息，用于搜索
 */
@property (nonatomic, strong) NSMutableArray *recordCityData;
/**
 *  定位城市
 */
@property (nonatomic, strong) NSMutableArray *localCityData;
/**
 *  热门城市
 */
@property (nonatomic, strong) NSMutableArray *hotCityData;
/**
 *  最近访问城市
 */
@property (nonatomic, strong) NSMutableArray *commonCityData;
@property (nonatomic, strong) NSMutableArray *arraySection;
/**
 *  是否是search状态
 */
@property(nonatomic, assign) BOOL isSearch;
/**
 *  搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;

/**
 *  搜索城市列表
 */
@property (nonatomic, strong) NSMutableArray *searchCities;


@end

NSString *const cityHeaderView = @"CityHeaderView";
NSString *const cityGroupCell = @"CityGroupCell";
NSString *const cityCell = @"CityCell";

@implementation LocationViewController
#pragma mark - 懒加载
-(UITableView *)locationView{
    
    if (!_locationView) {
        _locationView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _locationView.delegate = self;
        _locationView.dataSource = self;
    }
    return _locationView;
}


-(NSMutableArray *) cityDatas{
    if (_cityDatas == nil) {
        _cityDatas = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
        for (NSDictionary *city in array) {
            GYZCityGroup *group = [[GYZCityGroup alloc] init];
            group.groupName = [city objectForKey:@"key"];
            NSArray *cities = [city objectForKey:@"cities"];
            for (NSDictionary *dic in cities) {
                GYZCity *city = [[GYZCity alloc] init];
                city.cityID = [dic valueForKey:@"city_id"];
                city.cityName = [NSString stringWithFormat:@"%@市",dic[@"city_name"]];
                city.initials = [dic valueForKey:@"initial"];
                city.shortName = [dic valueForKey:@"initial"];
                city.pinyin = [NSString transform:[NSString stringWithFormat:@"%@市",dic[@"city_name"]]];
                [group.arrayCitys addObject:city];
                [self.recordCityData addObject:city];
            }
            [self.arraySection addObject:group.groupName];
            [_cityDatas addObject:group];
        }
    }
    return _cityDatas;
}

- (NSMutableArray *) recordCityData
{
    if (_recordCityData == nil) {
        _recordCityData = [[NSMutableArray alloc] init];
    }
    return _recordCityData;
}

- (NSMutableArray *) localCityData
{
    if (_localCityData == nil) {
        _localCityData = [[NSMutableArray alloc] init];
        if (self.locationCityID != nil) {
            GYZCity *city = nil;
            for (GYZCity *item in self.recordCityData) {
                if ([item.cityID isEqualToString:self.locationCityID]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", self.locationCityID);
            }
            else {
                [_localCityData addObject:city];
            }
        }
    }
    return _localCityData;
}

- (NSMutableArray *) hotCityData
{
    if (_hotCityData == nil) {
        _hotCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.hotCitys) {
            GYZCity *city = nil;
            for (GYZCity *item in self.recordCityData) {
                if ([item.cityID isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_hotCityData addObject:city];
            }
        }
    }
    return _hotCityData;
}

- (NSMutableArray *) commonCityData
{
    if (_commonCityData == nil) {
        _commonCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.commonCitys) {
            GYZCity *city = nil;
            for (GYZCity *item in self.recordCityData) {
                if ([item.cityName isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_commonCityData addObject:city];
            }
        }
    }
    return _commonCityData;
}

- (NSMutableArray *) arraySection
{
    if (_arraySection == nil) {
        _arraySection = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, @"定位", @"最近", @"最热", nil];
    }
    return _arraySection;
}

- (NSMutableArray *) commonCitys
{
    if (_commonCitys == nil) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:COMMON_CITY_DATA_KEY];
        _commonCitys = (array == nil ? [[NSMutableArray alloc] init] : [[NSMutableArray alloc] initWithArray:array copyItems:YES]);
    }
    return _commonCitys;
}

#pragma mark - Getter
- (NSMutableArray *) searchCities
{
    if (_searchCities == nil) {
        _searchCities = [[NSMutableArray alloc] init];
    }
    return _searchCities;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationData:) name:GETLOCATIONNOTIFICATION object:nil ];
}

-(void)getLocationData:(NSNotification *)sender{
    
    NSString *currCity = sender.userInfo[@"userCity"];
    if (self.localCityData.count <= 0) {
        GYZCity *city = [[GYZCity alloc] init];
        city.cityName = currCity;
        city.shortName = currCity;
        [self.localCityData addObject:city];
        [self.locationView reloadData];
    }
    NSLog(@"%@",currCity);
}

#pragma mark - 自定义
-(void)setUpViews{
    
    self.navigationItem.title = @"定位";
    [self.view addSubview:self.locationView];
    self.isSearch = NO;
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    //    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = @"城市名称或首字母";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    [self.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [self.searchBar.layer setBorderWidth:0.5f];
    [self.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    
    [self.locationView setTableHeaderView:self.searchBar];
    [self.locationView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.locationView setSectionIndexColor:[UIColor blueColor]];
    [self.locationView registerClass:[UITableViewCell class] forCellReuseIdentifier:cityCell];
    [self.locationView registerClass:[GYZCityGroupCell class] forCellReuseIdentifier:cityGroupCell];
    [self.locationView registerClass:[GYZCityHeaderView class] forHeaderFooterViewReuseIdentifier:cityHeaderView];
}

#pragma mark - Private Methods
- (void) didSelctedCity:(GYZCity *)city
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerController:didSelectCity:)]) {
        [_delegate cityPickerController:self didSelectCity:city];
    }
    
    if (self.commonCitys.count >= MAX_COMMON_CITY_NUMBER) {
        [self.commonCitys removeLastObject];
    }
    for (NSString *str in self.commonCitys) {
        if ([city.cityName isEqualToString:str]) {
            [self.commonCitys removeObject:str];
            break;
        }
    }
    [self.commonCitys insertObject:city.cityName atIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:self.commonCitys forKey:COMMON_CITY_DATA_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //搜索出来只显示一块
    if (self.isSearch) {
        return 1;
    }
    return self.cityDatas.count + 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isSearch) {
        return self.searchCities.count;
    }
    if (section < 3) {
        return 1;
    }
    GYZCityGroup *group = [self.cityDatas objectAtIndex:section - 3];
    return group.arrayCitys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isSearch) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
        GYZCity *city =  [self.searchCities objectAtIndex:indexPath.row];
        [cell.textLabel setText:city.cityName];
        return cell;
    }
    
    if (indexPath.section < 3) {
        GYZCityGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cityGroupCell];
        if (indexPath.section == 0) {
            cell.titleLabel.text = @"定位城市";
            cell.noDataLabel.text = @"无法定位当前城市，请稍后再试";
            [cell setCityArray:self.localCityData];
        }
        else if (indexPath.section == 1) {
            cell.titleLabel.text = @"最近访问城市";
            [cell setCityArray:self.commonCityData];
        }
        else {
            cell.titleLabel.text = @"热门城市";
            [cell setCityArray:self.hotCityData];
        }
        [cell setDelegate:self];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
    GYZCityGroup *group = [self.cityDatas objectAtIndex:indexPath.section - 3];
    GYZCity *city =  [group.arrayCitys objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section < 3 || self.isSearch) {
        return nil;
    }
    GYZCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cityHeaderView];
    NSString *title = [_arraySection objectAtIndex:section + 1];
    headerView.titleLabel.text = title;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (self.isSearch) {
        return 44.0f;
    }
    if (indexPath.section == 0) {
        return [GYZCityGroupCell getCellHeightOfCityArray:self.localCityData];
    }
    else if (indexPath.section == 1) {
        return [GYZCityGroupCell getCellHeightOfCityArray:self.commonCityData];
    }
    else if (indexPath.section == 2){
        return [GYZCityGroupCell getCellHeightOfCityArray:self.hotCityData];
    }
    return 44.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 3 || self.isSearch) {
        return 0.0f;
    }
    return 23.5f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GYZCity *city = nil;
    if (self.isSearch) {
        city =  [self.searchCities objectAtIndex:indexPath.row];
    }else{
        if (indexPath.section < 3) {
            if (indexPath.section == 0 && self.localCityData.count <= 0) {

            }
            return;
        }
        GYZCityGroup *group = [self.cityDatas objectAtIndex:indexPath.section - 3];
        city =  [group.arrayCitys objectAtIndex:indexPath.row];
    }
    [self didSelctedCity:city];
    NSNotification *notification = [NSNotification notificationWithName:@"selectedCity" object:nil userInfo:@{@"userCity":city.cityName,@"city_id":city.cityID}];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        return nil;
    }
    return self.arraySection;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0) {
        return -1;
    }
    return index - 1;
}

#pragma mark searchBarDelegete
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn=[searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchCities removeAllObjects];
    
    if (searchText.length == 0) {
        self.isSearch = NO;
    }else{
        self.isSearch = YES;
        for (GYZCity *city in self.recordCityData){
            NSRange chinese = [city.cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange  letters = [city.pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange  initials = [city.initials rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (chinese.location != NSNotFound || letters.location != NSNotFound || initials.location != NSNotFound) {
                [self.searchCities addObject:city];
            }
            //            if ([city.cityName containsString:searchText] || [city.pinyin containsString:searchText] || [city.initials containsString:searchText]) {
            //                [self.searchCities addObject:city];
            //            }
        }
    }
    [self.locationView reloadData];
}
//添加搜索事件：
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text=@"";
    [searchBar resignFirstResponder];
    self.isSearch = NO;
    [self.locationView reloadData];
}
#pragma mark GYZCityGroupCellDelegate
- (void) cityGroupCellDidSelectCity:(GYZCity *)city
{
    [self didSelctedCity:city];
    [self.locationView reloadData];
}
@end
