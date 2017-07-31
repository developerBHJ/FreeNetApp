//
//  HairDiscountViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/28.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "HairDiscountViewController.h"
#import "couponHeadView.h"
#import "cashCouponCell.h"
#import "discountCell.h"
#import "discountModel.h"
#import "DiscountViewController.h"
#import "couponClassCell.h"
@interface HairDiscountViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate,couponHeadViewDelegate>

@property (nonatomic,strong)UICollectionView *discountView;
@property (nonatomic,strong)NSMutableArray *discountData;
@property (nonatomic,strong)NSMutableArray *leftArr;
@property (nonatomic,strong)NSMutableArray *midlleArr;
@property (nonatomic,strong)NSMutableArray *rightArr;
@property (nonatomic,strong)couponHeadView *headView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *refreshBtn;

@end

@implementation HairDiscountViewController



#pragma mark >>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationAddress:) name:GETLOCATIONNOTIFICATION object:nil];

    [self setView];
}

-(void)getLocationAddress:(NSNotification *)sender{
    
    NSString *address = sender.userInfo[@"user_address"];
    self.titleLabel.text = address.length > 0 ? [NSString stringWithFormat:@"当前位置：%@",address] : @"正在定位中...";
    [self.discountView reloadData];
}

#pragma mark >>>> 懒加载
-(UICollectionView *)discountView{
    
    if (!_discountView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _discountView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 46, kScreenWidth, kScreenHeight - 106) collectionViewLayout:layout];
        _discountView.delegate = self;
        _discountView.dataSource = self;
        _discountView.backgroundColor = [UIColor clearColor];
    }
    return _discountView;
}

-(NSMutableArray *)discountData{
    
    if (!_discountData) {
        _discountData = [NSMutableArray new];
    }
    return _discountData;
}

-(NSMutableArray *)leftArr{
    
    if (!_leftArr) {
        _leftArr = [NSMutableArray new];
    }
    return _leftArr;
}

-(NSMutableArray *)midlleArr{
    
    if (!_midlleArr) {
        _midlleArr = [NSMutableArray new];
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"附近",@"高新区",@"未央区",@"莲湖区",@"雁塔区",@"长安区", nil];
        for (int i = 0; i < titleArr.count; i ++) {
            BHJDropModel *model = [[BHJDropModel alloc]init];
            model.title = titleArr[i];
            [_midlleArr addObject:model];
        }
    }
    return _midlleArr;
}

-(NSMutableArray *)rightArr{
    
    if (!_rightArr) {
        _rightArr = [NSMutableArray new];
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"智能排序",@"好评优先",@"离我最近",@"人均最低",@"价格最低",@"价格最高",@"最新发布", nil];
        for (int i = 0; i < titleArr.count; i ++) {
            BHJDropModel *model = [[BHJDropModel alloc]init];
            model.title = titleArr[i];
            [_rightArr addObject:model];
        }
    }
    return _rightArr;
}

-(couponHeadView *)headView{

    if (!_headView) {
        _headView = [couponHeadView shareCouponHeadView];
        _headView.leftData = self.leftArr;
        _headView.middleData = self.midlleArr;
        _headView.rightData = self.rightArr;
        [_headView.allBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_headView.locationBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_headView.sortBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        _headView.frame = CGRectMake(0, 64, kScreenWidth, 44);
        _headView.delegate = self;
    }
    return _headView;
}



#pragma mark >>>> 自定义
-(void)setView{
    
    self.navigationItem.title = @"发优惠";
    [self.view addSubview:self.discountView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self.discountView registerNib:[UINib nibWithNibName:@"cashCouponCell" bundle:nil] forCellWithReuseIdentifier:@"cashCouponCell"];
    [self.discountView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    UIButton *discountBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [discountBtn setFrame:CGRectMake(10, kScreenHeight - 50, kScreenWidth - 20, 40)];
    [discountBtn setTitle:@"我要发优惠" forState:UIControlStateNormal];
    [discountBtn setImage:[[UIImage imageNamed:@"Edit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [discountBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [discountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [discountBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    [discountBtn addTarget:self action:@selector(hairDiscount:) forControlEvents:UIControlEventTouchUpInside];
    [discountBtn setBackgroundColor:[UIColor colorWithHexString:@"#e4504b"]];
    discountBtn.cornerRadius = 4;
    [self.view addSubview:discountBtn];
    UISegmentedControl *headSegment = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"看会员",@"看企业"]];
    headSegment.frame = CGRectMake(50, 7, kScreenWidth - 100, 30);
    [headSegment setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
    [headSegment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}forState:UIControlStateNormal];
    self.navigationItem.titleView = headSegment;
    [self.discountView registerNib:[UINib nibWithNibName:@"discountCell" bundle:nil] forCellWithReuseIdentifier:@"discountCell"];
    
    for (int i = 0; i < 7; i ++) {
        discountModel *model = [[discountModel alloc]init];
        model.content = @"推荐理由：每次去都很满意，味道好，服务周到，菜好吃又有特色,物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错";
        if (i == 2 || i == 5 || i == 3) {
            model.imageAr = @[@"图层-1",@"图层-3",@"图层-4"];
        }else if (i == 0 || i == 4){
        model.content = @"推荐理由：每次去都很满意，味道好，服务周到，菜好吃又有特色,物美价廉真不错";
        model.imageAr = @[@"图层-1",@"图层-3",@"图层-4",@"图层-3",@"图层-4"];
        }
        [self.discountData addObject:model];
    }
    [self.view addSubview:self.headView];
}

-(void)back:(UIBarButtonItem *)sender{

    [self.headView removeMenu];
    [self.navigationController popViewControllerAnimated:YES];
}


// 发优惠
-(void)hairDiscount:(UIButton *)sender{

    DiscountViewController *discountVC = [[DiscountViewController alloc]init];
    [self.navigationController pushViewController:discountVC animated:YES];
}

-(void)refresh:(UIButton *)sender{
    
    [UIView transitionWithView:self.refreshBtn duration:2 options:UIViewAnimationOptionCurveLinear animations:^{
        self.refreshBtn.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        self.refreshBtn.transform = CGAffineTransformMakeRotation(0);
    }];
}

#pragma mark >>>> UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.discountData.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    discountModel *model = self.discountData[indexPath.row];
    return CGSizeMake(kScreenWidth, model.cellHeight);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    discountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"discountCell" forIndexPath:indexPath];
    cell.model = self.discountData[indexPath.row];
    if (indexPath.row == 1) {
        cell.headView.backgroundColor = HWColor(255, 178, 0, 1.0);
        cell.vertifyBtn.backgroundColor = HWColor(255, 178, 0, 1.0);
        [cell.vertifyBtn setTitle:@"商家认证" forState:UIControlStateNormal];
    }else if (indexPath.row == 2){
        cell.vertifyBtn.backgroundColor = [UIColor colorWithHexString:@"#dedede"];
        [cell.vertifyBtn setTitle:@"未认证" forState:UIControlStateNormal];
    }
    cell.delegate = self;
    cell.index = indexPath;
    cell.vertifyBtn.tag = 1000;
    cell.collectionBtn.tag = 1001;
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreenWidth - 50, 20)];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
        self.refreshBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:nil image:@"refresh" selector:@selector(refresh:) Frame:CGRectMake(kScreenWidth - 30, 5, 25, 25) viewController:self selectedImage:nil tag:2000];
        [headView addSubview:self.refreshBtn];
        [headView addSubview:self.titleLabel];
        return headView;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}

#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{

    switch (button.tag) {
        case 1000:{
        
            NSLog(@"认证");
        }
            break;
        case 1001:{
            
            NSLog(@"喜欢");
        }
            break;
            
        default:
            break;
    }

}



#pragma mark - couponHeadViewDelegate
-(void)couponHeadViewMethodWith:(couponHeaderViewStyle)viewStyle selectRow:(NSInteger)row selectedItem:(NSInteger)item{
    
    if (viewStyle == couponHeaderViewStyleWithLeft) {
        if (row == 3 && item == 0) {
            
        }
        NSLog(@"分类%ld    -- %ld",(long)row,item);
    }else if (viewStyle == couponHeaderViewStyleWithMiddle){
        NSLog(@"全城%ld    -- %ld",(long)row,item);
    }else if (viewStyle == couponHeaderViewStyleWithRight){
        NSLog(@"排序%ld    -- %ld",(long)row,item);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self refresh:self.refreshBtn];
}


@end
