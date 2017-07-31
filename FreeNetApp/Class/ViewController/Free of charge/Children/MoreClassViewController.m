//
//  MoreClassViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "MoreClassViewController.h"
#import "homeCell.h"
#import "moreClassHeadView.h"
#import "ClassModel.h"

#define kMoreUrl @"http://192.168.0.254:4004/publics/industries"
#define kSubClassUrl @"http://192.168.0.254:4004/publics/cates"
@interface MoreClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *moreClassView;
@property (nonatomic,strong)NSArray *moreClassData;
@property (nonatomic,strong)NSMutableDictionary *subClasses;

@end

@implementation MoreClassViewController
#pragma mark - 懒加载
-(UICollectionView *)moreClassView{
    
    if (!_moreClassView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _moreClassView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _moreClassView.delegate = self;
        _moreClassView.dataSource = self;
        _moreClassView.backgroundColor = [UIColor clearColor];
    }
    return _moreClassView;
}

-(NSMutableDictionary *)subClasses{
    
    if (!_subClasses) {
        _subClasses = [NSMutableDictionary new];
    }
    return _subClasses;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getMoreClassData];
    
    [self setUpViews];
}
#pragma mark - 自定义
-(void)setUpViews{
    
    self.navigationItem.title = @"更多分类";
    
    [self.view addSubview:self.moreClassView];
    [self.moreClassView registerNib:[UINib nibWithNibName:@"moreClassHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"moreClassHeadView"];
    [self.moreClassView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.moreClassView registerNib:[UINib nibWithNibName:@"homeCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
}

/**
 获取一级分类信息
 */
-(void)getMoreClassData{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:kMoreUrl parameters:nil success:^(id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            weak.moreClassData = [ClassModel mj_objectArrayWithKeyValuesArray:arr];
            for (ClassModel *model in weak.moreClassData) {
                NSDictionary *paramater = [NSDictionary dictionaryWithObjectsAndKeys:model.id,@"lid", nil];
                [self getSubClassDataWith:paramater];
            }
            [weak.moreClassView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取二级分类信息
 */
-(void)getSubClassDataWith:(NSDictionary *)paramater{
    
    __block NSArray *data = [NSArray new];
    NSString *key = [paramater objectForKey:@"lid"];
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:kSubClassUrl parameters:paramater success:^(id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"data"];
        if (arr.count > 0) {
            data = [ClassModel mj_objectArrayWithKeyValuesArray:arr];
            [weak.subClasses setObject:data forKey:key];
            [weak.moreClassView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.moreClassData.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    ClassModel *model = self.moreClassData[section];
    NSArray *sub = [self.subClasses objectForKey:model.id];
    return sub.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
    ClassModel *model = self.moreClassData[indexPath.section];
    NSArray *sub = [self.subClasses objectForKey:model.id];
    ClassModel *subModel = sub[indexPath.row];
    titlelabel.text = subModel.title;
    [titlelabel setFont:[UIFont systemFontOfSize:12]];
    titlelabel.textColor = [UIColor colorWithHexString:@"#696969"];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titlelabel];
    /*
     UIImageView *markView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.width / 8 * 3, cell.height / 5 * 2, cell.width / 4, cell.height / 5)];
     markView.image = [[UIImage imageNamed:@"drop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     [markView imageFillImageView];
     if(indexPath.section == 2 || indexPath.section == 3){
     if (indexPath.row == 11) {
     [cell.contentView addSubview:markView];
     }else{
     [cell.contentView addSubview:titlelabel];
     }
     }else{
     [cell.contentView addSubview:titlelabel];
     if (indexPath.section == 4) {
     if (indexPath.row == 3) {
     [titlelabel removeFromSuperview];
     }
     }
     }
     */
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth - 23) / 4, kScreenHeight / 14.56);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    moreClassHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"moreClassHeadView" forIndexPath:indexPath];
    ClassModel *model = self.moreClassData[indexPath.section];
    headView.model = model;
    [headView.themeImage sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    return headView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth - 20, kScreenHeight / 15.35);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld----%ld",(long)indexPath.section,indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
