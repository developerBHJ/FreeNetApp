//
//  EvaluateViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "EvaluateViewController.h"
#import "specialDetailCell_5.h"

#define kEvaluateUrl @"http://192.168.0.254:4004/special/productComments"

@interface EvaluateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *evaluateView;
@property (nonatomic,strong)NSMutableArray *evaluateData;
@property (nonatomic,strong)NSMutableDictionary *parameter;

@end

@implementation EvaluateViewController

#pragma mark - 懒加载
-(UICollectionView *)evaluateView{
    
    if (!_evaluateView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _evaluateView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _evaluateView.delegate = self;
        _evaluateView.dataSource = self;
        _evaluateView.backgroundColor = [UIColor clearColor];
    }
    return _evaluateView;
}

-(NSMutableArray *)evaluateData{
    
    if (!_evaluateData) {
        _evaluateData = [NSMutableArray new];
    }
    return _evaluateData;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.lid,@"lid", nil];
    }
    return _parameter;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
    
    [self getEvaluateDataWithUrl:kEvaluateUrl parameter:self.parameter];
    
    
}


#pragma mark - 自定义
-(void)setView{
    
    self.navigationItem.title = @"评论";
    [self.view addSubview:self.evaluateView];
    [self.evaluateView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.evaluateView registerNib:[UINib nibWithNibName:@"specialDetailCell_5" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_5"];
}

// 评论数据
-(void)getEvaluateDataWithUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    WeakSelf(weak)
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"][@"comments"];
        if (arr.count > 0) {
            weak.evaluateData = [EvaluateModel mj_objectArrayWithKeyValuesArray:arr];
        }
        [weak.evaluateView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.evaluateData.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    specialDetailCell_5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_5" forIndexPath:indexPath];
    EvaluateModel *model = self.evaluateData[indexPath.row];
    cell.model = model;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EvaluateModel *model = self.evaluateData[indexPath.row];
    return CGSizeMake(kScreenWidth - 2, model.cellHeight);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 1, 1, 1);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.1;
}

@end
