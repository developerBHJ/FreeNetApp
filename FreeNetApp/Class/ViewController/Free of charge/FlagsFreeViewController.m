//
//  FlagsFreeViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "FlagsFreeViewController.h"
#import "homeCell_2.h"

@interface FlagsFreeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *freeCollectionView;
@property (nonatomic,strong)NSMutableDictionary *freeData;

@end

@implementation FlagsFreeViewController

#pragma mark >>>> 懒加载
-(UICollectionView *)freeCollectionView{
    
    if (!_freeCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _freeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _freeCollectionView.delegate = self;
        _freeCollectionView.dataSource = self;
        _freeCollectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];

    }
    return _freeCollectionView;
}

-(NSMutableDictionary *)freeData{
    
    if (!_freeData) {
        _freeData = [NSMutableDictionary new];
    }
    return _freeData;
}
#pragma mark >>>> 生命周期


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"免费";
    [self.freeCollectionView registerNib:[UINib nibWithNibName:@"homeCell_2" bundle:nil] forCellWithReuseIdentifier:@"homeCell_2"];
    [self.view addSubview:self.freeCollectionView];
    
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
    
    homeCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell_2" forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath;
    cell.striveBtn.tag = 201;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSString *hourMinuteSecond = [dateFormatter stringFromDate:date];
    cell.time_h1.text = [hourMinuteSecond substringWithRange:NSMakeRange(0, 1)];
    cell.time_h2.text = [hourMinuteSecond substringWithRange:NSMakeRange(1, 1)];
    cell.time_m1.text = [hourMinuteSecond substringWithRange:NSMakeRange(3, 1)];
    cell.time_m2.text = [hourMinuteSecond substringWithRange:NSMakeRange(4, 1)];
    cell.time_s1.text = [hourMinuteSecond substringWithRange:NSMakeRange(6, 1)];
    cell.time_s2.text = [hourMinuteSecond substringWithRange:NSMakeRange(7, 1)];
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, kScreenHeight / 4.5);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
    [self.navigationController pushViewController:berserkVC animated:YES];
}

#pragma mark >>> BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    BerserkViewController *berserkVC = [[BerserkViewController alloc]init];
    [self.navigationController pushViewController:berserkVC animated:YES];
}

@end
