//
//  SpecialDetailViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "SpecialDetailViewController.h"
#import "specialDetailCell_1.h"
#import "MoreCouponViewController.h"
#import "specialFlagCell.h"
#import "FlagshipViewController.h"
#import "EvaluateViewController.h"
#import "specialDetailCell_5.h"
#import "specialHeadView.h"

#import "SpecialDetailModel.h"
#import "EvaluateModel.h"
#import "BHJPropertyView.h"
#define OtherUrl @"http://192.168.0.254:4004/special/details"
#define kEvaluateUrl @"http://192.168.0.254:4004/special/productComments"

@interface SpecialDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *detailView;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)NSMutableArray *markData;
@property (nonatomic,strong)SpecialDetailModel *model;
@property (nonatomic,strong)NSMutableDictionary *parameter;
@property (nonatomic,strong)NSMutableArray *evaluateData;

@end

@implementation SpecialDetailViewController
#pragma mark - 懒加载
-(UICollectionView *)detailView{
    
    if (!_detailView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _detailView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 64) collectionViewLayout:layout];
        _detailView.delegate = self;
        _detailView.dataSource = self;
        _detailView.backgroundColor = [UIColor clearColor];
    }
    return _detailView;
}

-(NSMutableArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}

-(NSMutableArray *)markData{
    
    if (!_markData) {
        _markData = [NSMutableArray arrayWithArray:@[@"味道很好 19",@"环境不错 19",@"服务态度很好 19",@"性价比高 19",@"交通方便 19",@"没有额外收费 18",@"就那样 19",@"交通方便 19",@"额外收费 19"]];
    }
    return _markData;
}

-(NSMutableArray *)evaluateData{
    
    if (!_evaluateData) {
        _evaluateData = [NSMutableArray new];
        /*
         for (int i = 0; i < 3; i ++) {
         BaseModel *model = [[BaseModel alloc]init];
         model.content = @"每次去都很满意，味道好，服务周到，菜好吃又有特色,物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错";
         if (i == 1) {
         model.imageAr = @[@"图层-1",@"图层-3",@"图层-4"];
         }
         if (i == 2) {
         model.imageAr = @[@"图层-1",@"图层-3",@"图层-4",@"图层-1",@"图层-2"];
         }
         [_evaluateData addObject:model];
         }
         */
    }
    return _evaluateData;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.lid,@"lid", nil];
    }
    return _parameter;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getSpecialDetailDataWithUrl:OtherUrl parameter:self.parameter];
    [self getEvaluateDataWithUrl:kEvaluateUrl parameter:self.parameter];
    [self setUpView];
}
#pragma mark - 自定义
-(void)setUpView{
    
    self.navigationItem.title = @"特价详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    [self.view addSubview:self.detailView];
    [self.detailView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_1" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_1"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_5" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_5"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialFlagCell" bundle:nil] forCellWithReuseIdentifier:@"specialFlagCell"];
    [self.detailView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView"];
}

//
-(void)share:(UITabBarItem *)sender{
    
    [[BHJTools sharedTools]showShareView];
}
#pragma mark - 网络数据
-(void)getSpecialDetailDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            self.model = [SpecialDetailModel mj_objectWithKeyValues:arr[0]];
            for (NSDictionary *dic in self.model.shop_product_images) {
                [self.imageArr addObject:dic[@"image_url"]];
            }
        }
        [self.detailView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

// 评论数据
-(void)getEvaluateDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"][@"comments"];
        if (arr.count > 0) {
            self.evaluateData = [EvaluateModel mj_objectArrayWithKeyValuesArray:arr];
        }
        [self.detailView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 协议
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 2){
        return self.evaluateData.count;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        specialFlagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialFlagCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.flagButton.tag = 2003;
        cell.titleLabel.text = self.model.shop[@"title"];
        //cell.cornerRadius = 5;
        return cell;
    }else if (indexPath.section == 1) {
        specialDetailCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_1" forIndexPath:indexPath];
        cell.delegate = self;
        cell.strveBtn.tag = 2001;
        cell.index = indexPath;
        cell.model = self.model;
        return cell;
    }else{
        specialDetailCell_5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_5" forIndexPath:indexPath];
        EvaluateModel *model = self.evaluateData[indexPath.row];
        cell.model = model;
        return cell;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 38);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenWidth, 81);
    }else{
        EvaluateModel *model = self.evaluateData[indexPath.row];
        return CGSizeMake(kScreenWidth - 2, model.cellHeight);
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }else{
        return UIEdgeInsetsMake(1, 0, 10, 0);
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.1;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor whiteColor];
        for (UIView *subView in headView.subviews) {
            [subView removeFromSuperview];
        }
        SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        scrollView.imageURLStringsGroup = self.imageArr;
        [headView addSubview:scrollView];
        return headView;
    }else {
        specialHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView" forIndexPath:indexPath];
        [headView.evaluateBtn setTitle:@"135人评价" forState:UIControlStateNormal];
        [headView.evaluateBtn addTarget:self action:@selector(evaluate) forControlEvents:UIControlEventTouchUpInside];
        return headView;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return CGSizeMake(kScreenWidth, 120);
    }else if (section == 2){
        return CGSizeMake(kScreenWidth, 35.5);
    }
    return CGSizeMake(0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
          //  [self evaluate];
        }
    }
}

#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 2000:{
            [self evaluate];
        }
            break;
        case 2001:{
            BHJPropertyView *propertyView = [[BHJPropertyView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            propertyView.specialModel = self.model;
            [propertyView showPropertyView];
        }
            break;
        case 2003:{
            FlagshipViewController *flagVC = [[FlagshipViewController alloc]init];
            flagVC.cid = self.model.shop[@"id"];
            [self.navigationController pushViewController:flagVC animated:YES];
        }
            break;
        default:
            break;
    }
}

//
-(void)evaluate{
    
    EvaluateViewController *evaluateVC = [[EvaluateViewController alloc]init];
    evaluateVC.markData = self.markData;
    evaluateVC.lid = self.lid;
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

@end
