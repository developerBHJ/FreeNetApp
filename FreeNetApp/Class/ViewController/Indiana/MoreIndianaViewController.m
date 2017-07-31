//
//  MoreIndianaViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/28.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "MoreIndianaViewController.h"
#import "indianaCell_1.h"
#import "IndianaModel.h"
#import "IndianaDetailViewController.h"

#define kAllData @"http://192.168.0.254:4004/indiana/all_lists"

@interface MoreIndianaViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *moreCollectionView;
@property (nonatomic,strong)NSArray *dataSource;

@end

@implementation MoreIndianaViewController
#pragma mark >>>> 懒加载
-(UICollectionView *)moreCollectionView{
    
    if (!_moreCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _moreCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _moreCollectionView.delegate = self;
        _moreCollectionView.dataSource = self;
        _moreCollectionView.backgroundColor = HWColor(239, 239, 239, 1.0);
        [_moreCollectionView registerNib:[UINib nibWithNibName:@"indianaCell_1" bundle:nil] forCellWithReuseIdentifier:@"indianaCell_1"];
    }
    return _moreCollectionView;
}
#pragma mark >>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部夺宝数据";
    
    [self.view addSubview:self.moreCollectionView];
    [self requestMoreIndianaData:kAllData];
}
#pragma mark >>>> 方法
-(void)requestMoreIndianaData:(NSString *)url{
    
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *data = responseObject[@"data"];
        if (data.count > 0) {
            weakSelf.dataSource = [IndianaModel mj_objectArrayWithKeyValuesArray:data];
            [weakSelf.moreCollectionView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}
#pragma mark >>>> UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    indianaCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"indianaCell_1" forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.dataSource[indexPath.row];
    cell.index = indexPath;
    cell.buyBtn.tag = 300;
    cell.tryBtn.tag = 301;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, 120);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IndianaModel *model = self.dataSource[indexPath.row];
    IndianaDetailViewController *detailVC = [[IndianaDetailViewController alloc]init];
    detailVC.lid = model.id;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark >>> BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 300:{
            IndianaDetailViewController *detailVC = [[IndianaDetailViewController alloc]init];
            IndianaModel *model = self.dataSource[index.row];
            detailVC.lid = model.id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 301:{
            IndianaDetailViewController *detailVC = [[IndianaDetailViewController alloc]init];
            IndianaModel *model = self.dataSource[index.row];
            detailVC.lid = model.id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}



@end
