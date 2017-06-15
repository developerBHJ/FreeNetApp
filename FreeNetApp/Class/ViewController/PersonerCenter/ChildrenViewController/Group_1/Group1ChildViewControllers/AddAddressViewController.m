//
//  AddAddressViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/17.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AddAddressViewController.h"

#import "STPickerView.h"
#import "STPickerArea.h"

#import "ZYLPickerView.h"

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
@property (weak, nonatomic) IBOutlet UILabel *zipLabel;
@property (weak, nonatomic) IBOutlet UITextField *zipTF;//邮政编码

@property (nonatomic,assign)BOOL isBool;
@end

@implementation AddAddressViewController



#pragma mark >>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveAddress.layer.cornerRadius = 5;
    self.saveAddress.layer.masksToBounds = YES;
    self.zipTF.delegate = self;
    self.zipTF.returnKeyType = UIReturnKeyDone;
    if (self.addressViewStyle == AddressStyleEdit) {
      //  [self setViewWithModelData];
    }
    
//    NSArray *addressArray = [[BHJTools sharedTools]readNSArrayFromSandboxWithName:@"area.plist"];
//    NSLog(@"地址plist文件 = %@",addressArray);
    
//    NSMutableArray *provinceArray = [NSMutableArray array];
//    for (NSDictionary *provinceDic in addressArray) {
//        [provinceArray addObject:provinceDic[@"province_name"]];
//    }
//    NSLog(@"%@",provinceArray);
    
   
        if (self.isBool) {
    
            self.isBool = NO;
            ZYLPickerView *zylpvc = [[ZYLPickerView alloc] initWithFrame:CGRectMake(0,kScreenHeight - 280, kScreenWidth, 280)];
            
            [self.view addSubview:zylpvc];
            __weak __typeof(self) weakself = self;
            
            zylpvc.SelectBlock = ^(NSString *proCityName){
                
                if (proCityName != nil) {
                    
//                    NSRange range = [proCityName rangeOfString:@" "];
//                    NSString *str = [proCityName substringToIndex:range.location];
//                    NSString *strt = [proCityName substringFromIndex:range.location + range.length];
//                    
//                    if ([str isEqualToString:strt]) {
//                        proCityName = str;
//                    }
                    
                    //UILabel *label = [self.view viewWithTag:1000 + indexPath.row];
                    //label.text = proCityName;
                    
                    //self.cityStr = [NSString stringWithFormat:@"%@,%@",str,strt];
                    //请求医院
                    //[self fetchHospitalWithURL:@"https://api.mamtree.com/doctor/hoss"];
                }
                weakself.isBool = YES;
            };
        }
}



#pragma mark >>>> 自定义
-(void)setViewWithModelData{

    self.nameTF.text = self.addressModel.name;
    self.phoneNumTF.text = self.addressModel.phoneNumber;
    self.cityTF.text = self.addressModel.city;
    self.addressTF.text = self.addressModel.address;
    self.zipTF.text = self.addressModel.zip;
}



#pragma mark - 保存
- (IBAction)saveAction:(UIButton *)sender {
    
    if (self.addressViewStyle == AddressStyleAdd) {
        //添加地址
        [self addShippingAddressWithURL:@"http://192.168.0.254:1000/personer/add_address"];
    }else if(self.addressViewStyle == AddressStyleEdit){
        //编辑地址
        [self editShippingAddressWithURL:@"http://192.168.0.254:1000/personer/edit_address"];
    }
}



- (IBAction)selectedAction:(BHJVerifyCodeButton *)sender {
    
    if (!sender.isClick) {
        [sender setBackgroundImage:[UIImage imageNamed:@"nomal"] forState:UIControlStateNormal];
        sender.isClick = YES;
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"selected_red"] forState:UIControlStateNormal];
        sender.isClick = NO;
    }
}



#pragma mark - TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.view endEditing:YES];
    return YES;
}



#pragma mark - 添加收货地址
-(void)addShippingAddressWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [parameter setValue:self.nameTF.textColor forKey:@"name"];
    [parameter setValue:self.phoneNumTF.textColor forKey:@"mobile"];
    [parameter setValue:@"" forKey:@"province_id"];
    [parameter setValue:@"" forKey:@"province_name"];
    [parameter setValue:@"" forKey:@"city_id"];
    [parameter setValue:@"" forKey:@"city_name"];
    [parameter setValue:@"" forKey:@"district_id"];
    [parameter setValue:@"" forKey:@"district_name"];
    [parameter setValue:self.addressTF.text forKey:@"address"];
    [parameter setValue:self.zipTF.textColor forKey:@"zipcode"];
    
    
    if (self.selectBtn.isClick == YES) {
        [parameter setValue:@"1" forKey:@"default"];
    }else{
        [parameter setValue:@"0" forKey:@"default"];
    }
    NSLog(@"添加地址参数 = %@",parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@",result);
        
        if ([result[@"status"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



#pragma mark - 编辑地址
-(void)editShippingAddressWithURL:(NSString *)url{

    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    [parameter setValue:self.nameTF.textColor forKey:@"name"];
    [parameter setValue:self.phoneNumTF.textColor forKey:@"mobile"];
    [parameter setValue:@"" forKey:@"province_id"];
    [parameter setValue:@"" forKey:@"province_name"];
    [parameter setValue:@"" forKey:@"city_id"];
    [parameter setValue:@"" forKey:@"city_name"];
    [parameter setValue:@"" forKey:@"district_id"];
    [parameter setValue:@"" forKey:@"district_name"];
    [parameter setValue:self.addressTF.text forKey:@"address"];
    [parameter setValue:self.zipTF.textColor forKey:@"zipcode"];
    
    
    if (self.selectBtn.isClick == YES) {
        [parameter setValue:@"1" forKey:@"default"];
    }else{
        [parameter setValue:@"0" forKey:@"default"];
    }
    NSLog(@"编辑地址参数 = %@",parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@",result);
        
        if ([result[@"status"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}




@end
