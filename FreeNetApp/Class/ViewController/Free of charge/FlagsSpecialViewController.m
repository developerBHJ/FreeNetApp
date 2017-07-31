//
//  FlagsSpecialViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "FlagsSpecialViewController.h"
#import "RecommendCell.h"
#import "SpecialDetailViewController.h"
#import "SpecialModel.h"
#define kFlagsSpecialUrl @"http://192.168.0.254:4004/special/shopspecial"

@interface FlagsSpecialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *specialCollectionView;
@property (nonatomic,strong)NSMutableArray *specialData;
@property (nonatomic,strong)NSMutableDictionary *paramater;


@end

@implementation FlagsSpecialViewController
#pragma mark >>>> 懒加载
-(UICollectionView *)specialCollectionView{
    
    if (!_specialCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _specialCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _specialCollectionView.delegate = self;
        _specialCollectionView.dataSource = self;
        _specialCollectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    return _specialCollectionView;
}

-(NSMutableArray *)specialData{
    
    if (!_specialData) {
        _specialData = [NSMutableArray new];
    }
    return _specialData;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.cid,@"cid",@"1",@"page", nil];
    }
    return _paramater;
}
#pragma mark >>>> 生命周期


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"特价";
    [self.specialCollectionView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCell"];
    [self.view addSubview:self.specialCollectionView];
    
    [self requestDataWith:kFlagsSpecialUrl paramater:self.paramater];
    
}

#pragma mark >>>> 自定义方法
-(void)requestDataWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weakself);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        weakself.specialData = [SpecialModel mj_objectArrayWithKeyValuesArray:responseObject];
        [weakself.specialCollectionView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark >>>> UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.specialData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
    cell.markLabel.text = @"已售 1022";
    cell.model = self.specialData[indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreenHeight / 15, kScreenHeight / 15)];
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 0) {
        imageView.image = [[UIImage imageNamed:@"taocan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        imageView.image = [[UIImage imageNamed:@"yuyue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [cell addSubview:imageView];
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, 95);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(2, 0, 5, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SpecialDetailViewController *detailVC = [[SpecialDetailViewController alloc]init];
    SpecialModel *model = self.specialData[indexPath.row];
    detailVC.lid = model.id;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
