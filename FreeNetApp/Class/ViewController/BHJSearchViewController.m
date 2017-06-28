//
//  BHJSearchViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/2/18.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "BHJSearchViewController.h"
#import "searchCell.h"
#import "SearchModel.h"
#import "CashDetailViewController.h"

@interface BHJSearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UICollectionView *resultView;
@property (nonatomic,strong)NSMutableDictionary *parameter;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation BHJSearchViewController
#pragma mark - 懒加载
-(UISearchBar *)searchBar{
    
    if (!_searchBar) {
        CGFloat barWidth = kScreenWidth / 3 * 2;
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(self.view.centerX - barWidth / 2, 12, barWidth, 20)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入关键字";
    }
    return _searchBar;
}

-(UICollectionView *)resultView{
    
    if (!_resultView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 10;
        _resultView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _resultView.delegate = self;
        _resultView.dataSource = self;
        _resultView.backgroundColor = [UIColor clearColor];
    }
    return _resultView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableDictionary *)parameter{
    
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"region_id",@"1",@"page", nil];
        switch (self.viewControllerStatu) {
            case 0:
            {
                [_parameter setValue:@"1" forKey:@"type"];
            }
                break;
            case 1:
            {
                [_parameter setValue:@"2" forKey:@"type"];
            }
                break;
            case 2:
            {
                [_parameter setValue:@"3" forKey:@"type"];
            }
                break;
            case 3:
            {
                [_parameter setValue:@"4" forKey:@"type"];
            }
                break;
                
            default:
                break;
        }
    }
    return _parameter;
}

#pragma mark - ViewDidLoad
-(void)viewWillAppear:(BOOL)animated{
    
    self.searchBar = nil;
    [self.dataArray removeAllObjects];
    [self.resultView reloadData];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.resultView registerNib:[UINib nibWithNibName:@"searchCell" bundle:nil] forCellWithReuseIdentifier:@"searchCell"];
    [self.view addSubview:self.resultView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(search:)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedCity:) name:@"selectedCity" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.searchBar resignFirstResponder];
    [self.searchBar removeFromSuperview];
}

-(void)selectedCity:(NSNotification *)sender{
    
    NSString *city_id = sender.userInfo[@"city_id"];
    if (city_id.length > 0) {
        [self.parameter setValue:city_id forKey:@"region_id"];
    }
}

#pragma mark - Search Event
-(void)search:(UIBarButtonItem *)sender{
    
    [self searchDataWithURL:SearchUrl parameter:self.parameter];
    [self.searchBar resignFirstResponder];
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    searchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, 44);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.searchBar resignFirstResponder];
    
    CashDetailViewController *cashDetailVC = [CashDetailViewController new];
    
    
    [self.navigationController pushViewController:cashDetailVC animated:YES];
}



#pragma mark - UISearchBar Delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length > 0) {
        [self.parameter setValue:searchText forKey:@"keyword"];
        [self searchDataWithURL:SearchUrl parameter:self.parameter];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];
    [self searchDataWithURL:SearchUrl parameter:self.parameter];
}

#pragma mark - 搜索数据请求
-(void)searchDataWithURL:(NSString *)url parameter:(NSDictionary *)parameter{
    
    [self.dataArray removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *data in result) {
            SearchModel *model = [SearchModel new];
            [model setValuesForKeysWithDictionary:data];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.resultView reloadData];
        });
        NSLog(@"==========%@",parameter);
        NSLog(@"--------%@",result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
