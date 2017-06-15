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
@interface FlagsSpecialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *specialCollectionView;
@property (nonatomic,strong)NSMutableDictionary *specialData;

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

-(NSMutableDictionary *)specialData{
    
    if (!_specialData) {
        _specialData = [NSMutableDictionary new];
    }
    return _specialData;
}
#pragma mark >>>> 生命周期


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"特价";
    [self.specialCollectionView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCell"];
    [self.view addSubview:self.specialCollectionView];
    
}

#pragma mark >>>> 自定义方法

#pragma mark >>>> UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
    cell.markLabel.text = @"已售 1022";
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreenHeight / 15, kScreenHeight / 15)];
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 0) {
        imageView.image = [[UIImage imageNamed:@"taocan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        imageView.image = [[UIImage imageNamed:@"yuyue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [cell addSubview:imageView];
    return cell;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, kScreenHeight / 6);
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
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
