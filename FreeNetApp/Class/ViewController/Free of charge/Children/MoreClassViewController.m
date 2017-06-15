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

@interface MoreClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *moreClassView;
@property (nonatomic,strong)NSMutableArray *moreClassData;


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

-(NSMutableArray *)moreClassData{
    
    if (!_moreClassData) {
        _moreClassData = [NSMutableArray new];
    }
    return _moreClassData;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
}
#pragma mark - 自定义
-(void)setUpViews{
    
    self.navigationItem.title = @"更多分类";
    [self.view addSubview:self.moreClassView];
    [self getData];
    [self.moreClassView registerNib:[UINib nibWithNibName:@"moreClassHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"moreClassHeadView"];
    [self.moreClassView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.moreClassView registerNib:[UINib nibWithNibName:@"homeCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
}


-(void)getData{
    
    PersonerGroup *model = [[PersonerGroup alloc]initWithTitle:@"热门" image:@"more_hot" subTitle:nil toViewController:nil];
    PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"餐饮" image:@"more_eat" subTitle:nil toViewController:nil];
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"娱乐" image:@"more_song" subTitle:nil toViewController:nil];
    PersonerGroup *model_3 = [[PersonerGroup alloc]initWithTitle:@"生活" image:@"more_life" subTitle:nil toViewController:nil];
    PersonerGroup *model_4 = [[PersonerGroup alloc]initWithTitle:@"游戏" image:@"more_game" subTitle:nil toViewController:nil];
    
    [self.moreClassData addObject:model];
    [self.moreClassData addObject:model_1];
    [self.moreClassData addObject:model_2];
    [self.moreClassData addObject:model_3];
    [self.moreClassData addObject:model_4];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.moreClassData.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 4) {
        return 4;
    }
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
    titlelabel.text = @"烤肉烤鱼";
    [titlelabel setFont:[UIFont systemFontOfSize:12]];
    titlelabel.textColor = [UIColor colorWithHexString:@"#696969"];
    titlelabel.textAlignment = NSTextAlignmentCenter;
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
    PersonerGroup *model = self.moreClassData[indexPath.section];
    headView.themeImage.image = [[UIImage imageNamed:model.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    headView.titleLabel.text = model.title;
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
