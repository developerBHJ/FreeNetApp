//
//  EvaluateViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/21.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "EvaluateViewController.h"
#import "IMJIETagView.h"
#import "IMJIETagFrame.h"
#import "specialDetailCell_5.h"

@interface EvaluateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,IMJIETagViewDelegate>

@property (nonatomic,strong)UICollectionView *evaluateView;
@property (nonatomic,strong)NSMutableArray *evaluateData;
@property (nonatomic,strong)IMJIETagView *tagView;

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

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setView];
    
    for (int i = 0; i < 7; i ++) {
        BaseModel *model = [[BaseModel alloc]init];
        model.content = @"每次去都很满意，味道好，服务周到，菜好吃又有特色,物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错，物美价廉真不错";
        if (i == 2 || i == 5 || i == 3) {
            model.imageAr = @[@"图层-1",@"图层-3",@"图层-4"];
        }
        if (i == 4) {
            model.imageAr = @[@"图层-1",@"图层-3",@"图层-4",@"图层-1",@"图层-2"];
        }
        [self.evaluateData addObject:model];
    }
}


#pragma mark - 自定义
-(void)setView{

    self.navigationItem.title = @"评论";
    [self.view addSubview:self.evaluateView];
    [self.evaluateView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.evaluateView registerNib:[UINib nibWithNibName:@"specialDetailCell_5" bundle:nil] forCellWithReuseIdentifier:@"specialDetailCell_5"];
}

-(void)addTagViewToCell:(UICollectionViewCell *)cell{
    
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 4.5;
    frame.tagsMargin = 5;
    frame.tagsLineSpacing = 9;
    frame.tagsArray = self.markData;
    
    self.tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.tagsHeight)];
    self.tagView.clickbool = YES;
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
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.width   - 70, self.tagView.bottom, 60, 20)];
    bottomLabel.text = @"135人评价";
    bottomLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [bottomLabel setFont:[UIFont systemFontOfSize:12]];
    [cell addSubview:bottomLabel];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }
    return self.evaluateData.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [self addTagViewToCell:cell];
        return cell;
    }else{
        specialDetailCell_5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"specialDetailCell_5" forIndexPath:indexPath];
        BaseModel *model = self.evaluateData[indexPath.row];
        cell.model = model;
        return cell;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth - 2, (self.markData.count / 3 + 1) * 40);
    }else{
    BaseModel *model = self.evaluateData[indexPath.row];
    return CGSizeMake(kScreenWidth - 2, model.cellHeight);
    }
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

#pragma mark - IMJIETagViewDelegate
-(void)IMJIETagView:(NSArray *)tagArray{
    
    NSInteger index = [tagArray[0] integerValue];
    NSLog(@"%@",[self.markData objectAtIndex:index]);
}







@end
