//
//  MemberViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/27.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MemberViewController.h"
#import "couponDetailCell_2.h"
#import "memberCell.h"
#import "memberCell_1.h"
#import "specialHeadView_1.h"
#import "flagCell_5.h"

#import "SearchRouteViewController.h"
#import "MemeberModel.h"
#define kFlagsMemberUrl @"http://192.168.0.254:4004/special/shopvip"

@interface MemberViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *memberView;
@property (nonatomic,assign)BOOL isReceived;
@property (nonatomic,strong)NSMutableDictionary *paramater;
@property (nonatomic,strong)MemeberModel *model;

@end

@implementation MemberViewController
#pragma mark - 懒加载
-(UICollectionView *)memberView{
    
    if (!_memberView) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
        _memberView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layOut];
        _memberView.delegate = self;
        _memberView.dataSource = self;
        _memberView.backgroundColor = [UIColor clearColor];
    }
    return _memberView;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.cid,@"cid",@"1",@"page", nil];
    }
    return _paramater;
}
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDataWith:kFlagsMemberUrl paramater:self.paramater];
    
    [self setUpView];
    
}

#pragma mark - 自定义
-(void)setUpView{
    
    self.isReceived = NO;
    self.navigationItem.title = @"会员卡";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    
    [self.view addSubview:self.memberView];
    [self.memberView registerNib:[UINib nibWithNibName:@"couponDetailCell_2" bundle:nil] forCellWithReuseIdentifier:@"couponDetailCell_2"];
    [self.memberView registerNib:[UINib nibWithNibName:@"memberCell" bundle:nil] forCellWithReuseIdentifier:@"memberCell"];
    [self.memberView registerNib:[UINib nibWithNibName:@"memberCell_1" bundle:nil] forCellWithReuseIdentifier:@"memberCell_1"];
    [self.memberView registerNib:[UINib nibWithNibName:@"specialHeadView_1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView_1"];
    [self.memberView registerNib:[UINib nibWithNibName:@"flagCell_5" bundle:nil] forCellWithReuseIdentifier:@"flagCell_5"];
    [self.memberView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
}


-(void)share:(UIBarButtonItem *)sender{
    
    [[BHJTools sharedTools]showShareView];
}

-(void)requestDataWith:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weakself);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] ==  200) {
            weakself.model = [MemeberModel mj_objectWithKeyValues:responseObject[@"data"]];
        }
        [weakself.memberView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 2 || section == 3) {
        return 2;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        memberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"memberCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.index = indexPath;
        cell.rightBtn.tag = 1000;
        cell.model = self.model;
        if (self.isReceived) {
            cell.bottomView.hidden = YES;
        }else{
            cell.bottomView.hidden = NO;
        }
        return cell;
    }else if (indexPath.section == 1){
        memberCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"memberCell_1" forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 2){
        couponDetailCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"couponDetailCell_2" forIndexPath:indexPath];
        cell.addressBtn.tag = 1001;
        cell.phoneBtn.tag = 1002;
        cell.delegate = self;
        cell.index = indexPath;
        if (indexPath.row == 1) {
            cell.markLabel.text = @"450m";
            cell.markLabel.backgroundColor = [UIColor clearColor];
            cell.markLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        }
        return cell;
    }else{
        flagCell_5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"flagCell_5" forIndexPath:indexPath];
        cell.MembershipBtn.hidden = YES;
        cell.leadingSpace.constant = 20;
        cell.markView.hidden = YES;
        cell.markLabel.hidden = YES;
        cell.titleLabel.text = @"骨头菜馆VIP会员卡";
        [cell.titleLabel setFont:[UIFont systemFontOfSize:12]];
        cell.titleLabel.textColor = [UIColor colorWithHexString:@"#696969"];
        cell.membershipWidth.constant = 30;
        return cell;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (self.isReceived) {
            return CGSizeMake(kScreenWidth, 142);
        }
        return CGSizeMake(kScreenWidth, 126);
    }else if (indexPath.section == 1){
        return CGSizeMake(kScreenWidth, 95);
    }else if (indexPath.section == 3){
        return CGSizeMake(kScreenWidth, 38);
    }
    return CGSizeMake(kScreenWidth, 126);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 3) {
        return 1;
    }
    return 10;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (section == 1){
        if (self.isReceived) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
        return UIEdgeInsetsMake(10, 0, 0, 0);
    }else if (section == 3){
        return UIEdgeInsetsMake(1, 0, 10, 0);
    }
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
    for (UIView *subView in headView.subviews) {
        [subView removeFromSuperview];
    }
    if (indexPath.section == 1) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setImage:[[UIImage imageNamed:@"flag_phone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [tempBtn setTitle:@"买单前向服务员出示此卡" forState:UIControlStateNormal];
        [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [tempBtn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
        tempBtn.frame = CGRectMake(headView.centerX - 80, 5, 160, 20);
        [tempBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        [headView addSubview:tempBtn];
        return headView;
    }else if (indexPath.section == 3){
        specialHeadView_1 *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView_1" forIndexPath:indexPath];
        headView.markLabel.text = @"卡";
        [headView.markLabel setFont:[UIFont systemFontOfSize:12]];
        headView.themeLabel.text = @"为您推荐";
        return headView;
    }
    return headView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 3) {
        return CGSizeMake(kScreenWidth, 38);
    }else if (section == 1){
        if (self.isReceived) {
            return CGSizeMake(kScreenWidth, 28);
        }
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(0, 0);
}
#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 1000:{
            self.isReceived = YES;
            [self.memberView reloadData];
        }
            break;
        case 1001:{
            SearchRouteViewController  *searchRouteVC = [[SearchRouteViewController alloc]init];
            [self.navigationController pushViewController:searchRouteVC animated:YES];
        }
            break;
        case 1002:{
            NSLog(@"打电话");
        }
            break;
            
        default:
            break;
    }
}

@end
