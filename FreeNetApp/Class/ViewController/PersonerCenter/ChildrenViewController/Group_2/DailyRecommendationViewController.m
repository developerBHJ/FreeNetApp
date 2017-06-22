//
//  DailyRecommendationViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "DailyRecommendationViewController.h"
#import "RecommendCell.h"
#import "RecommendationDetailViewController.h"

@interface DailyRecommendationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *recommendationView;
@property (nonatomic,strong)NSMutableArray *recommentdationData;

@end

@implementation DailyRecommendationViewController
#pragma mark - 懒加载
-(UICollectionView *)recommendationView{

    if (!_recommendationView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 10;
        _recommendationView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight - 55) collectionViewLayout:layout];
        _recommendationView.delegate = self;
        _recommendationView.dataSource = self;
        _recommendationView.backgroundColor = HWColor(241, 241, 241, 1.0);
    }
    return _recommendationView;
}

-(NSMutableArray *)recommentdationData{

    if (!_recommentdationData) {
        _recommentdationData = [[NSMutableArray alloc]init];
    }
    return _recommentdationData;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
    
}

#pragma mark - 自定义
-(void)setView{

    self.navigationItem.title = @"每日推荐";
    
    
    for (int i = 0; i < 10; i ++) {
        BaseModel *model = [[BaseModel alloc]init];
        [self.recommentdationData addObject:model];
    }
    
    [self.view addSubview:self.recommendationView];
    
    [self.recommendationView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCell"];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UISegmentedControl *segementView = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"免费",@"夺宝"]];
    segementView.selectedSegmentIndex = 0;
    [segementView setFrame:CGRectMake(kScreenWidth * 0.05, 10, kScreenWidth * 0.9, 35)];
//    segementView.segmentedControlStyle = UISegmentedControlSegmentAlone;
    [segementView addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
//    [segementView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [segementView setTintColor:[UIColor redColor]];
    [backView addSubview:segementView];
}

-(void)changeView:(UISegmentedControl *)sender{

    if (sender.selectedSegmentIndex == 0) {
        [self.recommentdationData removeAllObjects];
        for (int i = 0; i < 10; i ++) {
            BaseModel *model = [[BaseModel alloc]init];
            [self.recommentdationData addObject:model];
        }
    }else if (sender.selectedSegmentIndex == 1){
        [self.recommentdationData removeAllObjects];
        for (int i = 0; i < 3; i ++) {
            BaseModel *model = [[BaseModel alloc]init];
            [self.recommentdationData addObject:model];
        }
    }else{
        [self.recommentdationData removeAllObjects];
        for (int i = 0; i < 2; i ++) {
            BaseModel *model = [[BaseModel alloc]init];
            [_recommentdationData addObject:model];
        }
    }
    [self.recommendationView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.recommentdationData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    RecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    RecommendationDetailViewController *detailVC = [[RecommendationDetailViewController alloc]init];
    detailVC.navgationTitle = @"每日推荐商品详情";
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(kScreenWidth - 20, kScreenHeight / 6);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(2, 10, 10, 10);
}
@end
