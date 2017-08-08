//
//  AddressViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AddressViewController.h"
#import "addAddressCell.h"
#import "addressEditCell.h"
#import "addressCell.h"
#import "AddAddressViewController.h"
#import "addressCell_1.h"
#import "AddressModel.h"

@interface AddressViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *addressView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation AddressViewController



#pragma mark - Init
-(UICollectionView *)addressView{
    
    if (!_addressView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 15;
        layout.minimumLineSpacing = 10;
        _addressView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _addressView.delegate = self;
        _addressView.dataSource = self;
        _addressView.backgroundColor = HWColor(225, 225, 225, 1.0);
        [self.view addSubview:_addressView];
    }
    return _addressView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    self.view.backgroundColor = HWColor(196, 196, 127, 1.0);
    
    [self.addressView registerNib:[UINib nibWithNibName:@"addAddressCell" bundle:nil] forCellWithReuseIdentifier:@"addAddressCell"];
    [self.addressView registerNib:[UINib nibWithNibName:@"addressEditCell" bundle:nil] forCellWithReuseIdentifier:@"addressEditCell"];
    [self.addressView registerNib:[UINib nibWithNibName:@"addressCell" bundle:nil] forCellWithReuseIdentifier:@"addressCell"];
    [self.addressView registerNib:[UINib nibWithNibName:@"addressCell_1" bundle:nil] forCellWithReuseIdentifier:@"addressCell_1"];
    
    //获取地址
    [self fetchAddressWithURL:API_URL(@"/users/addresses")];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeViewStatus:) name:@"changeViewStatus" object:nil];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - NSNotification
-(void)changeViewStatus:(NSNotification *)info{

    BOOL isEdit = info.userInfo[@"isEdit"];
    if (isEdit) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishEdit:)];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.isEdit = isEdit;
    [self.addressView reloadData];
}

/**
 完成编辑
 
 @param sender 导航栏右侧按钮
 */
-(void)finishEdit:(UIBarButtonItem *)sender{
  
    self.navigationItem.rightBarButtonItem = nil;
    self.isEdit = NO;
    [self.addressView reloadData];
}
#pragma mark - Collection Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0 || section == 2) {
        return 1;
    }
    return [collectionView showMessage:@"您还没有收货地址，快去添加吧" byDataSourceCount:self.dataArray.count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {  //添加
        addAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addAddressCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 2){ //编辑
        addressEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addressEditCell" forIndexPath:indexPath];
        return cell;
    }else{  //数据
        if (self.isEdit == YES) {
            addressCell_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addressCell_1" forIndexPath:indexPath];
            cell.model = self.dataArray[indexPath.row];
            cell.defalutBtn.tag = 1000;
            cell.deleteBtn.tag = 1001;
            cell.editBtn.tag = 1002;
            cell.delegate = self;
            cell.index = indexPath;
            return cell;
        }else{
            addressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addressCell" forIndexPath:indexPath];
            cell.model = self.dataArray[indexPath.row];
            return cell;
        }
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 || indexPath.section == 2) {
        return CGSizeMake(kScreenWidth - 20, 50);
    }else{
        if (self.isEdit == YES) {
            return CGSizeMake(kScreenWidth - 20, 130);
        }else{
            return CGSizeMake(kScreenWidth - 20, 75);
        }
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 0) {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }else if (section == 1){
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AddAddressViewController *addVC = [[AddAddressViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        addVC.navgationTitle = @"创建收货地址";
        addVC.addressViewStyle = AddressStyleAdd;
        [self.navigationController pushViewController:addVC animated:YES];
    }else if (indexPath.section == 2){
        NSNotification *notification = [[NSNotification alloc]initWithName:@"changeViewStatus" object:nil userInfo:@{@"isEdit":@(YES)}];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }else{
        AddAddressViewController *addVC = [[AddAddressViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        addVC.addressViewStyle = AddressStyleEdit;
        addVC.navgationTitle = @"修改收货地址";
        AddressModel *model = self.dataArray[indexPath.row];
        addVC.addressId = model.addressId;
        [self.navigationController pushViewController:addVC animated:YES];
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}
#pragma mark - BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 1000:{
            //设为默认
            [self setToTheDefaultAddressWithURL:API_URL(@"/users/addresses/enabled") Index:index];
        }
            break;
        case 1002:{
            //添加
            AddAddressViewController *editVC = [[AddAddressViewController alloc]init];
            AddressModel *model = self.dataArray[index.row];
            editVC.navgationTitle = @"修改地址";
            editVC.addressId = model.addressId;
            editVC.addressViewStyle = AddressStyleEdit;
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        case 1001:{
            //删除
            [self deleteAddressWithURL:API_URL(@"/users/addresses/erase") Index:index];
        }
            break;
        default:
            break;
    }
}



#pragma mark - 获取收货地址
-(void)fetchAddressWithURL:(NSString *)url{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *data in result[@"data"]) {
            AddressModel *model = [AddressModel new];
            [model setValuesForKeysWithDictionary:data];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.addressView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



#pragma mark - 设为默认地址
-(void)setToTheDefaultAddressWithURL:(NSString *)url Index:(NSIndexPath *)index{
    
    AddressModel *model = self.dataArray[index.row];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:model.addressId forKey:@"address_id"];
    WeakSelf(weakSelf);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 200) {
            
            [ShowMessage showMessage:result[@"message"] duration:3];
            [weakSelf.dataArray removeAllObjects];
            [weakSelf fetchAddressWithURL:API_URL(@"/users/addresses")];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



#pragma mark - 删除收货地址
-(void)deleteAddressWithURL:(NSString *)url  Index:(NSIndexPath *)index{
    
    AddressModel *model = self.dataArray[index.row];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:model.addressId forKey:@"address_id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 200) {
            [ShowMessage showMessage:result[@"message"] duration:3];
            [self.dataArray removeObjectAtIndex:index.row];
            [self.addressView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
