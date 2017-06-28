//
//  AddAddressViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveAddress;//保存按钮
@property (weak, nonatomic) IBOutlet UILabel *setDefault;
@property (weak, nonatomic) IBOutlet BHJVerifyCodeButton *selectBtn;//设置默认按钮
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;//姓名
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//电话
@property (weak, nonatomic) IBOutlet UITextField *cityTF;//城市
@property (weak, nonatomic) IBOutlet UITextField *addressTF;//详细地址
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,assign)BOOL isBool;
@end

@implementation AddAddressViewController



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveAddress.layer.cornerRadius = 5;
    self.saveAddress.layer.masksToBounds = YES;
    
    if (self.addressViewStyle == AddressStyleEdit) {
        NSString *url = [NSString stringWithFormat:@"%@%@",API_URL(@"/users/addresses/"),self.addressId];
        [self fetchAddressDetailWithURL:url];
    }
}



#pragma mark - 保存
- (IBAction)saveAction:(UIButton *)sender {
    
    if (self.addressViewStyle == AddressStyleAdd) {
        //添加地址
        [self addShippingAddressWithURL:API_URL(@"/users/addresses")];
    }else if(self.addressViewStyle == AddressStyleEdit){
        //编辑地址
        [self editShippingAddressWithURL:API_URL(@"/users/addresses/update")];
    }
}



#pragma mark - 设置默认
- (IBAction)selectedAction:(BHJVerifyCodeButton *)sender {
    
    if (!sender.isClick) {
        [sender setBackgroundImage:[UIImage imageNamed:@"nomal"] forState:UIControlStateNormal];
        sender.isClick = YES;
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"selected_red"] forState:UIControlStateNormal];
        sender.isClick = NO;
    }
}



#pragma mark - 获取地址详细信息
-(void)fetchAddressDetailWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.addressId forKey:@"address_id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSDictionary *dataDic = result[@"data"];
        
        self.nameTF.text = dataDic[@"truename"];
        self.phoneNumTF.text = dataDic[@"mobile"];
        self.cityTF.text = [NSString stringWithFormat:@"%@ %@ %@",dataDic[@"province"],dataDic[@"city"],dataDic[@"district"]];
        self.addressTF.text = dataDic[@"address"];
        
        if ([dataDic[@"status"] boolValue] == YES) {

            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"selected_red"] forState:(UIControlStateNormal)];
        }else{
            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"nomal"] forState:(UIControlStateNormal)];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}





#pragma mark - 添加收货地址
-(void)addShippingAddressWithURL:(NSString *)url{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.addressId forKey:@"address_id"];
    [parameter setValue:self.nameTF.text forKey:@"truename"];
    [parameter setValue:self.phoneNumTF.text forKey:@"mobile"];
    [parameter setValue:@"陕西省" forKey:@"province"];
    [parameter setValue:@"西安市" forKey:@"city"];
    [parameter setValue:@"未央区" forKey:@"district"];
    [parameter setValue:self.addressTF.text forKey:@"address"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];

        if ([result[@"status"] intValue] == 200) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [ShowMessage showMessage:result[@"message"] duration:3];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



#pragma mark - 编辑地址
-(void)editShippingAddressWithURL:(NSString *)url{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:self.addressId forKey:@"address_id"];
    [parameter setValue:self.nameTF.text forKey:@"truename"];
    [parameter setValue:self.phoneNumTF.text forKey:@"mobile"];
    [parameter setValue:@"陕西省" forKey:@"province"];
    [parameter setValue:@"西安市" forKey:@"city"];
    [parameter setValue:@"未央区" forKey:@"district"];
    [parameter setValue:self.addressTF.text forKey:@"address"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 200) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [ShowMessage showMessage:result[@"message"] duration:3];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
