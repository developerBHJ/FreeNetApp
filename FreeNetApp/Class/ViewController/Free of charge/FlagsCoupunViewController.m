//
//  FlagsCoupunViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/28.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "FlagsCoupunViewController.h"
#import "CashDetailViewController.h"
#import "CashCouponModel.h"
#import "FlagsMemeberCell.h"
#define kCouponUrl @"http://192.168.0.254:4004/special/shopcoupons"

@interface FlagsCoupunViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *couponView;
@property (nonatomic,strong)NSMutableArray *couponData;
@property (nonatomic,strong)NSMutableDictionary *paramater;

@end

@implementation FlagsCoupunViewController
#pragma mark - Lazy
-(UICollectionView *)couponView{
    
    if (!_couponView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _couponView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _couponView.delegate = self;
        _couponView.dataSource = self;
        _couponView.backgroundColor = HWColor(239, 239, 239, 1.0);
    }
    return _couponView;
}

-(NSMutableArray *)couponData{
    
    if (!_couponData) {
        _couponData = [NSMutableArray new];
    }
    return _couponData;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.cid,@"cid",@"1",@"page", nil];
    }
    return _paramater;
}
#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"现金券";
    [self.view addSubview:self.couponView];
    [self.couponView registerNib:[UINib nibWithNibName:@"FlagsMemeberCell" bundle:nil] forCellWithReuseIdentifier:@"FlagsMemeberCell"];
    
    [self requestDataWith:kCouponUrl paramater:self.paramater];
    
}
#pragma mark - Method
-(void)requestDataWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weakself);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        NSArray *data = responseObject[@"data"];
        if (data.count > 0) {
            weakself.couponData = [CashCouponModel mj_objectArrayWithKeyValuesArray:data];
        }
        [weakself.couponView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - Collection Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.couponData.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, 95);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FlagsMemeberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlagsMemeberCell" forIndexPath:indexPath];
    cell.model = self.couponData[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CashDetailViewController *detailVC = [[CashDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end
