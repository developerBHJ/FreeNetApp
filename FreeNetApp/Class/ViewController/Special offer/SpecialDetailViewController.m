//
//  SpecialDetailViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "SpecialDetailViewController.h"
#import "specialDetailCell.h"
#import "specialDetailCell_1.h"
#import "specialDetailCell_2.h"
#import "specialHeadView.h"
#import "specialHeadView_1.h"
#import "specialDetailCell_3.h"
#import "specialDetailCell_4.h"
#import "specialDetailCell_5.h"
#import "specialDetailCell_6.h"
#import "specialiDetailCell_7.h"
#import "IMJIETagFrame.h"
#import "IMJIETagView.h"
#import "MoreCouponViewController.h"
#import "specialFlagCell.h"
#import "FlagshipViewController.h"

#import "EvaluateViewController.h"

#define OtherUrl @"http://192.168.0.254:1000/special/other_index"

@interface SpecialDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,IMJIETagViewDelegate,BaseCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *detailView;
@property (nonatomic,strong)NSMutableArray *detailData;
@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)NSMutableArray *markData;
@property (nonatomic,strong)IMJIETagView *tagView;
@property (nonatomic,strong)NSMutableArray *evaluateData;
@property (nonatomic,strong)NSMutableDictionary *parameter;

@end

@implementation SpecialDetailViewController
#pragma mark - 懒加载
-(UICollectionView *)detailView{
    
    if (!_detailView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _detailView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 64) collectionViewLayout:layout];
        _detailView.delegate = self;
        _detailView.dataSource = self;
        _detailView.backgroundColor = [UIColor clearColor];
    }
    return _detailView;
}


-(NSMutableArray *)detailData{
    
    if (!_detailData) {
        _detailData = [NSMutableArray new];
    }
    return _detailData;
}

-(NSMutableArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr = [NSMutableArray arrayWithArray:@[@"图层-1",@"图层-3",@"图层-4"]];
    }
    return _imageArr;
}

-(NSMutableArray *)markData{
    
    if (!_markData) {
        _markData = [NSMutableArray arrayWithArray:@[@"味道很好 19",@"环境不错 19",@"服务态度很好 19",@"性价比高 19",@"交通方便 19",@"没有额外收费 18",@"就那样 19",@"交通方便 19",@"额外收费 19"]];
    }
    return _markData;
}

-(NSMutableArray *)evaluateData{
    
    if (!_evaluateData) {
        _evaluateData = [NSMutableArray new];
        for (int i = 0; i < 3; i ++) {
            BaseModel *model = [[BaseModel alloc]init];
            model.content = @"每次去都很满意，味道好，服务周到，菜好吃又有特色,物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错";
            if (i == 1) {
                model.imageAr = @[@"图层-1",@"图层-3",@"图层-4"];
            }
            if (i == 2) {
                model.imageAr = @[@"图层-1",@"图层-3",@"图层-4",@"图层-1",@"图层-2"];
            }
            [_evaluateData addObject:model];
        }
    }
    return _evaluateData;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(self.model.id),@"id", nil];
    }
    return _parameter;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getSpecialDetailDataWithUrl:OtherUrl parameter:self.parameter];
    
    [self setUpView];
}
#pragma mark - 自定义
-(void)setUpView{
    
    self.navigationItem.title = @"特价详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    [self.view addSubview:self.detailView];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell"];
    [self.detailView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.detailView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_1" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_1"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_2" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_2"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialHeadView_1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView_1"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_3" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_3"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_4" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_4"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_5" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_5"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialDetailCell_6" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_6"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialiDetailCell_7" bundle:nil] forCellWithReuseIdentifier:@"specialiDetailCell_7"];
    [self.detailView registerNib:[UINib nibWithNibName:@"specialFlagCell" bundle:nil] forCellWithReuseIdentifier:@"specialFlagCell"];
}

//
-(void)share:(UITabBarItem *)sender{
  
    [[BHJTools sharedTools]showShareView];
}

//
-(void)addTagViewToCell:(UICollectionViewCell *)cell{
    
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 4.5;
    frame.tagsMargin = 5;
    frame.tagsLineSpacing = 9;
    frame.tagsArray = self.markData;
    
    self.tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.tagsHeight)];
    self.tagView.clickbool = NO;
    self.tagView.borderSize = 0.5;
    self.tagView.clickborderSize = 0.5;
    self.tagView.tagsFrame = frame;
    self.tagView.clickBackgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    self.tagView.clickTitleColor = [UIColor colorWithHexString:@"#e4504b"];
    self.tagView.clickStart = 0;
    //    tagView.clickString = @"味道很好 19";//单选  tagView.clickStart 为0
    self.tagView.clickArray = @[@"味道很好 19",@"环境不错 19",@"服务态度很好 19"];//多选 tagView.clickStart 为1
    self.tagView.delegate = self;
    [cell addSubview:self.tagView];
}
#pragma mark - 网络数据
-(void)getSpecialDetailDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                SpecialModel *model = [SpecialModel mj_objectWithKeyValues:dic];
                [self.detailData addObject:model];
            }
        }
        [self.detailView reloadSections:[NSIndexSet indexSetWithIndex:3]];
        NSLog(@"请求数据成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

#pragma mark - 协议
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 2;
    }else if (section == 2){
        return 3;
    }else if (section == 3){
        return 3;
    }
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        specialFlagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialFlagCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.flagButton.tag = 2003;
        //cell.cornerRadius = 5;
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            specialDetailCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_1" forIndexPath:indexPath];
            cell.delegate = self;
            cell.commentBtn.tag = 2000;
            cell.strveBtn.tag = 2001;
            cell.index = indexPath;
            return cell;
        }else{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            [self addTagViewToCell:cell];
            return cell;
        }
    }else if (indexPath.section == 2){
        specialDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell" forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 3){
        specialDetailCell_2 *cell_2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_2" forIndexPath:indexPath];
       // cell_2.model = self.detailData[indexPath.row];
        return cell_2;
    }else{
        specialDetailCell_4 *cell_4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_4" forIndexPath:indexPath];
        return cell_4;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, kScreenHeight / 15);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return CGSizeMake(kScreenWidth, kScreenHeight / 4);
        }else{
            return CGSizeMake(kScreenWidth, (self.markData.count / 3 + 1) * 34);
        }
    }
    return CGSizeMake(kScreenWidth, kScreenHeight / 6);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }else{
        return UIEdgeInsetsMake(1, 0, 10, 0);
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.1;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor whiteColor];
        for (UIView *subView in headView.subviews) {
            [subView removeFromSuperview];
        }
        SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 4.73)];
        scrollView.localizationImageNamesGroup = self.imageArr;
        [headView addSubview:scrollView];
        return headView;
    }else if (indexPath.section == 2){
        specialHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView" forIndexPath:indexPath];
        return headView;
    }else if (indexPath.section == 3){
        specialHeadView_1 *headView_1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"specialHeadView_1" forIndexPath:indexPath];
        headView_1.markLabel.text = @"减";
        headView_1.themeLabel.text = @"本商家的其他特价";
        return headView_1;
    }else{
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        return headView;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return CGSizeMake(kScreenWidth, kScreenHeight / 4.73);
    }else if (section == 2){
        return CGSizeMake(kScreenWidth, kScreenHeight / 12);
    }else if (section == 3){
        return CGSizeMake(kScreenWidth, kScreenHeight / 15);
    }
    return CGSizeMake(0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            EvaluateViewController *evaluateVC = [[EvaluateViewController alloc]init];
            evaluateVC.markData = self.markData;
            [self.navigationController pushViewController:evaluateVC animated:YES];
        }
    }
}

#pragma mark - IMJIETagViewDelegate
-(void)IMJIETagView:(NSArray *)tagArray{
    
    NSInteger index = [tagArray[0] integerValue];
    NSLog(@"%@",[self.markData objectAtIndex:index]);
}

#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 2000:{
            EvaluateViewController *evaluateVC = [[EvaluateViewController alloc]init];
            evaluateVC.markData = self.markData;
            [self.navigationController pushViewController:evaluateVC animated:YES];
        }
            break;
        case 2001:{
            NSLog(@"抢购");
        }
            break;
        case 2003:{
            FlagshipViewController *flagVC = [[FlagshipViewController alloc]init];
            [self.navigationController pushViewController:flagVC animated:YES];
        }
            break;
        default:
            break;
    }
}




@end
