//
//  MoreCouponViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/23.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MoreCouponViewController.h"
#import "specialDetailCell_2.h"

@interface MoreCouponViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *moreView;


@end

@implementation MoreCouponViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的特价";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    [self.view addSubview:self.moreView];
    [self.moreView registerNib:[UINib nibWithNibName:@"specialDetailCell_2" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_2"];
}
#pragma mark - 懒加载
-(UICollectionView *)moreView{

    if (!_moreView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _moreView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _moreView.delegate = self;
        _moreView.dataSource = self;
        _moreView.backgroundColor = [UIColor clearColor];
    }
    return _moreView;
}




#pragma mark - 自定义
-(void)share:(UIBarButtonItem *)sender{

    [[BHJTools sharedTools]showShareView];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    specialDetailCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_2" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 1;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(kScreenWidth, kScreenHeight / 6);
}


@end
