//
//  WinningRecordViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "WinningRecordViewController.h"
#import "winningCell.h"

@interface WinningRecordViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *recordView;
@property (nonatomic,strong)NSMutableArray *recordData;

@end

@implementation WinningRecordViewController
#pragma mark - 懒加载
-(UICollectionView *)recordView{

    if (!_recordView) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
        _recordView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layOut];
        _recordView.delegate = self;
        _recordView.dataSource = self;
        _recordView.backgroundColor = [UIColor clearColor];
    }
    return _recordView;
}


-(NSMutableArray *)recordData{

    if (!_recordData) {
        _recordData = [NSMutableArray new];
    }
    return _recordData;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpView];

}

#pragma mark - 自定义
-(void)setUpView{

    self.navigationItem.title = @"中奖记录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    [self.view addSubview:self.recordView];
    [self.recordView registerNib:[UINib nibWithNibName:@"winningCell" bundle:nil] forCellWithReuseIdentifier:@"winningCell"];

}

-(void)share:(UIBarButtonItem *)sender{

    [[BHJTools sharedTools]showShareView];
}

#pragma mark - 协议
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 5;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    winningCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"winningCell" forIndexPath:indexPath];
    return cell;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 10;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 10, 0);
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(kScreenWidth, kScreenHeight / 4);
}

@end
