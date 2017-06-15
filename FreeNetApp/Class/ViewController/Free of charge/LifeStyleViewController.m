//
//  LifeStyleViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/2.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "LifeStyleViewController.h"
#import "PersonalHobby.h"
#import "FreeViewController.h"
@interface LifeStyleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *markView;
@property (nonatomic,strong)NSMutableArray *markArray;
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)UIProgressView *progressView;

@end

@implementation LifeStyleViewController

#pragma mark >>>>>>>> 懒加载
-(UICollectionView *)markView{
    
    if (!_markView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _markView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, MainScreen_height / 7.2, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _markView.delegate = self;
        _markView.dataSource = self;
        _markView.backgroundColor = [UIColor clearColor];
        _markView.scrollEnabled = NO;
    }
    return _markView;
}

#pragma mark >>>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
}
#pragma mark >>>>>>>> 自定义
-(void)setView{

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 30, 25, 25);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    backBtn.backgroundColor = [UIColor clearColor];
    UILabel *themeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.centerX - 45, 30, 90, 25)];
    themeLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [themeLabel setFont:[UIFont systemFontOfSize:20]];
    themeLabel.text = @"生活状态";
    themeLabel.textAlignment = NSTextAlignmentCenter;
    themeLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:themeLabel];
    
    [self.markView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hobbyBackView"]];
    [self.view addSubview:self.markView];
    [self.markArray removeAllObjects];
    NSDictionary *hobbyDic = [PersonalHobby setTagData];
    self.markArray = [NSMutableArray arrayWithArray:[hobbyDic objectForKey:@"Lifestyle"]];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 3, kScreenWidth, 10)];
    self.progressView.progress = 1.0;
    [self.progressView setProgressTintColor:[UIColor colorWithHexString:@"#e6605c"]];
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    [self.progressView setTrackTintColor:[UIColor colorWithHexString:@"#f4bdbc"]];
    [self.view addSubview:self.progressView];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.nextBtn setFrame:CGRectMake(10, CGRectGetMinY(self.progressView.frame) - kScreenHeight * 0.164, kScreenWidth - 20, kScreenHeight / 12.35)];
    [self.nextBtn addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.borderWidth = 1;
    self.nextBtn.borderColor = HWColor(241, 241, 241, 1.0);
    [self.nextBtn setTitle:@"开启我的智能立免" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor colorWithHexString:@"#e6605c"] forState:UIControlStateNormal];
    [self.nextBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.nextBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.nextBtn];
}

-(void)nextView:(UIButton *)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)backAction:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark >>>>>>>> UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.markArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    PersonalHobby *hobby = self.markArray[indexPath.row];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame))];
    titleLabel.text = hobby.themeTitle;
    titleLabel.textColor = hobby.themeColor;
    cell.backgroundColor = [UIColor whiteColor];
    cell.cornerRadius = CGRectGetWidth(cell.frame) / 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = hobby.backColor;
    [titleLabel setFont:[UIFont systemFontOfSize:21]];
    if (hobby.themeTitle.length > 3) {
        NSString *str = [hobby.themeTitle substringToIndex:2];
        NSString *str_1 = [hobby.themeTitle substringFromIndex:2];
        NSString *str_2 = [str stringByAppendingFormat:@" \n %@",str_1];
        titleLabel.text = str_2;
    }
    titleLabel.tag = 500 + indexPath.row;
    [cell addSubview:titleLabel];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth / 2.83, kScreenWidth / 2.83);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return kScreenWidth / 14.2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return kScreenHeight / 32.5;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, kScreenHeight / 21.8, 10, kScreenHeight / 21.8);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalHobby *hobby = self.markArray[indexPath.row];
    NSLog(@"%@",hobby.themeTitle);
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *titleLabel = [cell viewWithTag:500 + indexPath.row];
    cell.backgroundColor = [UIColor colorWithHexString:@"#e66053"];
    titleLabel.textColor = [UIColor whiteColor];
}

@end
