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

#define kCount self.dataArray.count

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
    }
    return _addressView;
}

-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark >>>>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.addressView];
    self.navigationItem.title = @"收货地址";
    self.view.backgroundColor = HWColor(196, 196, 127, 1.0);
    [self.addressView registerNib:[UINib nibWithNibName:@"addAddressCell" bundle:nil] forCellWithReuseIdentifier:@"addAddressCell"];
    [self.addressView registerNib:[UINib nibWithNibName:@"addressEditCell" bundle:nil] forCellWithReuseIdentifier:@"addressEditCell"];
    [self.addressView registerNib:[UINib nibWithNibName:@"addressCell" bundle:nil] forCellWithReuseIdentifier:@"addressCell"];
    [self.addressView registerNib:[UINib nibWithNibName:@"addressCell_1" bundle:nil] forCellWithReuseIdentifier:@"addressCell_1"];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(addAddress:) name:@"modifyAddress" object:nil];
    
    
    //获取地址
    [self fetchAddressWithURL:@"http://192.168.0.254:1000/personer/my_address"];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"modifyAddress" object:nil];
}



#pragma mark >>>>>>> 自定义
-(void)addAddress:(NSNotification *)sender{
    
    NSMutableArray *array = sender.userInfo[@"address"];
    for (BaseModel *model in array) {
        [self.addressData addObject:model];
    }
    [self.addressView reloadData];
}



#pragma mark >>>>>>> UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return kCount + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == kCount) {  //添加
        addAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addAddressCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == kCount + 1){ //编辑
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
    
    if (indexPath.row == kCount || (indexPath.row == kCount + 1)) {
        return CGSizeMake(kScreenWidth - 20, kScreenHeight / 11.59);
    }else{
        if (self.isEdit == YES) {
            return CGSizeMake(kScreenWidth - 20, kScreenHeight / 4.5);
        }else{
            return CGSizeMake(kScreenWidth - 20, kScreenHeight / 8);
        }
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == kCount) {
        AddAddressViewController *addVC = [[AddAddressViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        addVC.navgationTitle = @"创建收货地址";
        [self.navigationController pushViewController:addVC animated:YES];
    }else if (indexPath.row == kCount + 1){
        self.isEdit = YES;
        [self.addressView reloadData];
    }
}

#pragma mark >>>>>>> BaseCollectionViewCellDelegate
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 1000:{
            [button setTitle:@"默认地址" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"e4504b"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        }
            break;
        case 1002:{
            AddAddressViewController *editVC = [[AddAddressViewController alloc]init];
            editVC.addressViewStyle = AddressStyleEdit;
            BaseModel *model = self.addressData[index.row];
            editVC.addressModel = model;
            editVC.index = index.row;
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        case 1001:{
            [self deleteAddressWithURL:@"http://192.168.0.254:1000/personer/addressDel" Index:index];
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
    [parameter setValue:user_id forKey:@"userId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];

        for (NSDictionary *data in result) {
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




#pragma mark - 删除收货地址
-(void)deleteAddressWithURL:(NSString *)url Index:(NSIndexPath *)index{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    AddressModel *model = [AddressModel new];
    model = self.dataArray[index.row];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:model.addressId forKey:@"did"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 0) {
            [ShowMessage showMessage:result[@"message"] duration:3];
            [self.dataArray removeObjectAtIndex:index.row];
            [self.addressView reloadData];
        }else{
            [ShowMessage showMessage:result[@"message"] duration:3];
        }
        
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
