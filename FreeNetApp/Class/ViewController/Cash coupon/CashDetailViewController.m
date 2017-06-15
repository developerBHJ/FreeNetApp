//
//  CashDetailViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "CashDetailViewController.h"
#import "cashCouponCell.h"
#import "couponDetailCell.h"
#import "couponModel.h"
#import "couponDetailHeadView.h"
#import "couponDetailCell_1.h"
#import "couponDetailCell_2.h"
#import "couponDetailHeadView_1.h"
#import "specialFlagCell.h"
#import "FlagshipViewController.h"

@interface CashDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate,BHJReusableViewDelegate>

@property (nonatomic,strong)UICollectionView *cashDetailView;
@property (nonatomic,strong)NSMutableArray *cashDetailData;

@end

@implementation CashDetailViewController



#pragma mark - Init
-(UICollectionView *)cashDetailView{
    
    if (!_cashDetailView) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
        _cashDetailView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 44) collectionViewLayout:layOut];
        _cashDetailView.delegate = self;
        _cashDetailView.dataSource = self;
        _cashDetailView.backgroundColor = [UIColor clearColor];
    }
    return _cashDetailView;
}

-(NSMutableArray *)cashDetailData{
    
    if (!_cashDetailData) {
        _cashDetailData = [NSMutableArray new];
        couponModel *model_1 = [[couponModel alloc]init];
        model_1.markData = @[@"不支持随时退",@"不支持过期退"];
        [_cashDetailData addObject:model_1];
    }
    return _cashDetailData;
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}



#pragma mark - 自定义
-(void)setView{
    
    self.navigationItem.title = @"现金券";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    [self.view addSubview:self.cashDetailView];
    
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"cashCouponCell" bundle:nil] forCellWithReuseIdentifier:@"cashCouponCell"];
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"specialHeadView_1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView_1"];
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"couponDetailCell" bundle:nil] forCellWithReuseIdentifier:@"couponDetailCell"];
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"couponDetailHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"couponDetailHeadView"];
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"couponDetailCell_1" bundle:nil] forCellWithReuseIdentifier:@"couponDetailCell_1"];
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"couponDetailCell_2" bundle:nil] forCellWithReuseIdentifier:@"couponDetailCell_2"];
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"couponDetailHeadView_1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"couponDetailHeadView_1"];
    [self.cashDetailView registerNib:[UINib nibWithNibName:@"specialFlagCell" bundle:nil] forCellWithReuseIdentifier:@"specialFlagCell"];
    
}

// 分享
-(void)share:(UIBarButtonItem *)sender{
    
    [[BHJTools sharedTools]showShareView];
}



#pragma mark - Collection Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 2){
        return 5;
    }else if(section == 1){
        return 5;
    }
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        specialFlagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialFlagCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.flagButton.tag = 203;
        return cell;
    }
    if (indexPath.section == 2) {
        cashCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cashCouponCell" forIndexPath:indexPath];
        cell.saleNum.hidden = YES;
        cell.validityLabel.hidden = YES;
        return cell;
    }else{
        if (indexPath.row == 0) {
            couponDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"couponDetailCell" forIndexPath:indexPath];
            couponModel *model = self.cashDetailData[indexPath.row];
            cell.model = model;
            cell.delegate = self;
            cell.index = indexPath;
            cell.exChangeBtn.tag = 202;
            return cell;
        }else if (indexPath.row == 1){
            couponDetailCell_1 *cell_1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"couponDetailCell_1" forIndexPath:indexPath];
            return cell_1;
        }else{
            couponDetailCell_2 *cell_2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"couponDetailCell_2" forIndexPath:indexPath];
            cell_2.delegate = self;
            cell_2.addressBtn.tag = 200;
            cell_2.phoneBtn.tag = 201;
            cell_2.index = indexPath;
            if (indexPath.row == 3) {
                cell_2.markLabel.text = @"502m";
                cell_2.markLabel.textColor = [UIColor colorWithHexString:@"#696969"];
                cell_2.markLabel.backgroundColor = [UIColor clearColor];
            }
            return cell_2;
        }
    }
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, kScreenHeight / 15);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            couponModel *model = self.cashDetailData[indexPath.row];
            return CGSizeMake(kScreenWidth, model.cellHeight);
        }else if (indexPath.row == 1){
            return CGSizeMake(kScreenWidth, kScreenHeight / 5);
        }else{
            return CGSizeMake(kScreenWidth, kScreenHeight / 4.8);
        }
    }
    return CGSizeMake(kScreenWidth, kScreenHeight / 4);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 2) {
        return UIEdgeInsetsMake(1, 0, 10, 0);
    }
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    couponDetailHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"couponDetailHeadView" forIndexPath:indexPath];
    return headView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return CGSizeMake(kScreenWidth, kScreenHeight / 4.89);
    }else {
        return CGSizeMake(kScreenWidth, 0);
    }
}

#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 200:{
            //  LocationWithMapViewController *locationVC = [[LocationWithMapViewController alloc]init];
            //            [self.navigationController pushViewController:locationVC animated:YES];
        }
            break;
        case 201:{
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:@[@"010-466686789",@"010-466686789"] distance:kScreenHeight / 5];
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
                NSLog(@"%@",text);
            }];
        }
            break;
        case 202:{
            NSLog(@"立即购买");
        }
            break;
        case 203:{
            FlagshipViewController *flagVC = [[FlagshipViewController alloc]init];
            [self.navigationController pushViewController:flagVC animated:YES];
        }
            break;
        default:
            break;
    }
}




@end
