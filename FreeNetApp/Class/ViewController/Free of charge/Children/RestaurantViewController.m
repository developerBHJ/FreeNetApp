//
//  RestaurantViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "RestaurantViewController.h"
#import "couponHeadView.h"
#import "homeCell_2.h"
#import "RecommendCell.h"
#import "indianaCell_1.h"
#import "BHJDropModel.h"
#import "HairDiscountViewController.h"
#import "IndianaDetailViewController.h"
#import "BerserkViewController.h"
#import "SpecialDetailViewController.h"

#define CalssFreeDetailUrl @"http://192.168.0.254:1000/free/cate_details"
#define CalssSpecialDetailUrl @"http://192.168.0.254:1000/special/special_cates"

@interface RestaurantViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,couponHeadViewDelegate,BaseCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *restaurantView;
@property (nonatomic,strong)NSMutableDictionary *restautantData;
@property (nonatomic,strong)couponHeadView *headView;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,strong)UIButton *selectedBtn;

@property (nonatomic,strong)NSMutableArray *leftArr;
@property (nonatomic,strong)NSMutableArray *midlleArr;
@property (nonatomic,strong)NSMutableArray *rightArr;
@property (nonatomic,strong)arrowView *bubbleView;
@property (nonatomic,strong)UIButton *refreshBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)NSString *user_address;
@property (nonatomic,strong)NSMutableDictionary *parameter;


@end

@implementation RestaurantViewController

#pragma mark >>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationAddress:) name:GETLOCATIONNOTIFICATION object:nil];
    [self setView];
    switch (self.viewStyle) {
        case 0:
        {
            [self getDataWithUrl:CalssFreeDetailUrl parameter:self.parameter];
        }
            break;
        case 1:
        {
            [self getDataWithUrl:CalssSpecialDetailUrl parameter:self.parameter];
        }
            break;
        case 2:
        {
            [self getDataWithUrl:CalssFreeDetailUrl parameter:self.parameter];
        }
            break;
            
        default:
            break;
    }
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

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.headView removeMenu];
}
#pragma mark >>>> 懒加载
-(UICollectionView *)restaurantView{
    
    if (!_restaurantView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _restaurantView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 46, kScreenWidth, kScreenHeight - 46) collectionViewLayout:layout];
        _restaurantView.delegate = self;
        _restaurantView.dataSource = self;
        _restaurantView.backgroundColor = HWColor(239, 239, 239, 1.0);
    }
    return _restaurantView;
}

-(NSMutableDictionary *)restautantData{
    
    if (!_restautantData) {
        _restautantData = [NSMutableDictionary new];
    }
    return _restautantData;
}


-(couponHeadView *)headView{
    
    if (!_headView) {
        _headView = [couponHeadView shareCouponHeadView];
        _headView.frame = CGRectMake(0, 64, kScreenWidth, 44);
        _headView.leftData = self.leftArr;
        _headView.middleData = self.midlleArr;
        _headView.rightData = self.rightArr;
        [_headView.allBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_headView.locationBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_headView.sortBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        _headView.frame = CGRectMake(0, 64, kScreenWidth, 44);
        _headView.delegate = self;
    }
    return _headView;
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


-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2822",@"region_id",@(self.class_id),@"cid", nil];
    }
    return _parameter;
}
#pragma mark >>>> 自定义
-(void)setView{
    
    switch (self.class_id) {
        case 8:
        {
            self.navigationItem.title = @"餐饮";
        }
            break;
        case 9:
        {
            self.navigationItem.title = @"娱乐";
        }
            break;
        case 10:
        {
            self.navigationItem.title = @"生活";
        }
            break;
            
        default:
            break;
    }
    [self.view addSubview:self.restaurantView];
    [self.view addSubview:self.headView];
    [self.restaurantView registerNib:[UINib nibWithNibName:@"homeCell_2" bundle:nil] forCellWithReuseIdentifier:@"homeCell_2"];
    [self.restaurantView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCell"];
    [self.restaurantView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.restaurantView registerNib:[UINib nibWithNibName:@"indianaCell_1" bundle:nil] forCellWithReuseIdentifier:@"indianaCell_1"];
    NSArray *timeArr = @[@"12:00",@"14:00",@"16:00",@"19:00",@"21:00"];
    [self.restautantData setObject:timeArr forKey:@"time"];
}

// 分类
-(void)classification:(UITapGestureRecognizer *)sender{
    
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        NSLog(@"分类");
    }else{
        NSLog(@"分类2121");
    }
}

// 定位
-(void)location:(UITapGestureRecognizer *)sender{
    
    NSLog(@"定位");
}

-(void)back:(UIBarButtonItem *)sender{
    
    [self.headView removeMenu];
    [self.navigationController popViewControllerAnimated:YES];
}
// 排序
-(void)sort:(UITapGestureRecognizer *)sender{
    
    NSLog(@"排序");
}

// 整点开抢
-(void)striveTime:(UIButton *)sender{
    
    [self selectedButton:sender];
    switch (sender.tag) {
        case 1000:{
            NSLog(@"%ld",(long)sender.tag);
        }
            break;
        case 1001:{
            NSLog(@"%ld",(long)sender.tag);
        }
            break;
        case 1002:{
            NSLog(@"%ld",(long)sender.tag);
        }
            break;
        case 1003:{
            NSLog(@"%ld",(long)sender.tag);
        }
            break;
        case 1004:{
            NSLog(@"%ld",(long)sender.tag);
        }
            break;
        default:
            break;
    }
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
    [self.selectedBtn setBackgroundColor:HWColor(248, 248, 248, 1.0)];
    [self.selectedBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.selectedBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.selectedBtn = sender;
    sender.enabled = NO;
}

-(void)refresh:(UIButton *)sender{
    
    [UIView transitionWithView:self.refreshBtn duration:2 options:UIViewAnimationOptionCurveLinear animations:^{
        self.refreshBtn.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        self.refreshBtn.transform = CGAffineTransformMakeRotation(0);
    }];
}

// 网络数据
-(void)getDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSMutableArray *data = [NSMutableArray new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                switch (self.viewStyle) {
                    case 0:
                    {
                        HotRecommend *hot = [HotRecommend mj_objectWithKeyValues:dic];
                        [data addObject:hot];
                    }
                        break;
                    case 1:
                    {
                        SpecialModel *model = [SpecialModel mj_objectWithKeyValues:dic];
                        [data addObject:model];
                    }
                        break;
                    case 2:
                    {
                        IndianaModel *model = [IndianaModel mj_objectWithKeyValues:dic];
                        [data addObject:model];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
        NSLog(@"----------------%@",array);
        [self.restautantData setObject:data forKey:@"data"];
        [self.restaurantView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        NSLog(@"请求数据成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

#pragma mark >>>> UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    NSArray *data = [self.restautantData objectForKey:@"data"];
    return data.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, kScreenHeight / 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *data = [self.restautantData objectForKey:@"data"];
    
    if (self.viewStyle == ViewStleWithFreeData) {
        homeCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell_2" forIndexPath:indexPath];
        cell.delegate = self;
        cell.striveBtn.tag = 1000;
        cell.index = indexPath;
        cell.model = data[indexPath.row];
        return cell;
    }else if (self.viewStyle == ViewStleWithSpecialData){
        RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
        cell.model = data[indexPath.row];
        return cell;
    }else{
        indianaCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"indianaCell_1" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        cell.model = data[indexPath.row];
        return cell;
    }
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        for (UIView *subView in headView.subviews) {
            [subView removeFromSuperview];
        }
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreenWidth - 50, 20)];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        self.titleLabel.text = [NSString stringWithFormat:@"当前位置：%@",self.user_address];
        [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [headView addSubview:self.titleLabel];
        
        self.refreshBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:nil image:@"refresh" selector:@selector(refresh:) Frame:CGRectMake(kScreenWidth - 30, 5, 25, 25) viewController:self selectedImage:nil tag:2000];
        [headView addSubview:self.refreshBtn];
        
        
        self.bubbleView = [[arrowView alloc]initWithFrame:CGRectMake(0,0, 16, 0)];
        [headView addSubview:self.bubbleView];
        if (self.viewStyle == ViewStleWithFreeData) {
            NSArray *timeArr = [self.restautantData objectForKey:@"time"];
            for (int i = 0; i < 5; i ++) {
                UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [timeBtn setTitle:timeArr[i] forState:UIControlStateNormal];
                CGFloat btnWidth = kScreenWidth / 5;
                [timeBtn setFrame:CGRectMake(btnWidth * i, 30, btnWidth, kScreenHeight / 15)];
                [timeBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
                [timeBtn addTarget:self action:@selector(striveTime:) forControlEvents:UIControlEventTouchUpInside];
                timeBtn.tag = 1000 + i;
                timeBtn.backgroundColor = HWColor(248, 248, 248, 1.0);
                [headView addSubview:timeBtn];
                if (i == 1) {
                    [self selectedButton:timeBtn];
                }
            }
        }
        return headView;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        if (self.viewStyle == ViewStleWithFreeData) {
            return CGSizeMake(kScreenWidth, 70);
        }
        return CGSizeMake(kScreenWidth, 30);
    }
    return CGSizeMake(0, 0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(2, 0, 10, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewStyle == ViewStleWithIndianaData) {
        IndianaDetailViewController *detaileVC = [[IndianaDetailViewController alloc]init];
        [self.navigationController pushViewController:detaileVC animated:YES];
    }else if (self.viewStyle == ViewStleWithFreeData){
        BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
        [self.navigationController pushViewController:berserkVC animated:YES];
    }else{
        SpecialDetailViewController *specialDetailVC = [[SpecialDetailViewController alloc]init];
        [self.navigationController pushViewController:specialDetailVC animated:YES];
    }
}

#pragma mark - couponHeadViewDelegate
-(void)couponHeadViewMethodWith:(couponHeaderViewStyle)viewStyle selectRow:(NSInteger)row selectedItem:(NSInteger)item{
    
    if (viewStyle == couponHeaderViewStyleWithLeft) {
        if (row == 3 && item == 0) {
            HairDiscountViewController *discountVC = [[HairDiscountViewController alloc]init];
            [self.navigationController pushViewController:discountVC animated:YES];
        }
        NSLog(@"分类%ld    -- %ld",(long)row,item);
    }else if (viewStyle == couponHeaderViewStyleWithMiddle){
        NSLog(@"全城%ld    -- %ld",(long)row,item);
    }else if (viewStyle == couponHeaderViewStyleWithRight){
        NSLog(@"排序%ld    -- %ld",(long)row,item);
    }
}

#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    if (self.viewStyle == ViewStleWithIndianaData) {
        IndianaDetailViewController *detaileVC = [[IndianaDetailViewController alloc]init];
        [self.navigationController pushViewController:detaileVC animated:YES];
    }else if (self.viewStyle == ViewStleWithFreeData){
        BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
        [self.navigationController pushViewController:berserkVC animated:YES];
    }else{
        SpecialDetailViewController *specialDetailVC = [[SpecialDetailViewController alloc]init];
        [self.navigationController pushViewController:specialDetailVC animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self refresh:self.refreshBtn];
}

@end
