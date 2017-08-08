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

@property (nonatomic,strong)NSMutableDictionary *paramater;

@end

@implementation AddAddressViewController

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        if (self.addressViewStyle == AddressStyleAdd) {
            _paramater = [NSMutableDictionary dictionaryWithDictionary:@{@"user_id":user_id,@"type":@""}];
        }else{
            _paramater = [NSMutableDictionary dictionaryWithDictionary:@{@"user_id":user_id,@"type":@(0)}];
        }
    }
    return _paramater;
}
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
    
    [self.paramater setValue:self.nameTF.text forKey:@"truename"];
    [self.paramater setValue:self.phoneNumTF.text forKey:@"mobile"];
    [self.paramater setValue:self.cityTF.text forKey:@"provinces"];
    [self.paramater setValue:self.addressTF.text forKey:@"addres"];
    if (self.addressViewStyle == AddressStyleAdd) {
        //添加地址
        [self addShippingAddressWithURL:API_URL(@"/users/addresses") parameter:self.paramater];
    }else if(self.addressViewStyle == AddressStyleEdit){
        [self.paramater setValue:self.addressId forKey:@"address_id"];
        //编辑地址
        [self editShippingAddressWithURL:@"http://192.168.0.254:4004/users/addresses/update" paramater:self.paramater];
    }
}


#pragma mark - 设置默认
- (IBAction)selectedAction:(BHJVerifyCodeButton *)sender {
    
    sender.isClick = !sender.isClick;
    if (!sender.isClick) {
        [sender setBackgroundImage:[UIImage imageNamed:@"nomal"] forState:UIControlStateNormal];
        if (self.addressViewStyle == AddressStyleAdd) {
            [self.paramater setValue:@"" forKey:@"type"];
        }else{
            [self.paramater setValue:@(0) forKey:@"type"];
        }
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"selected_red"] forState:UIControlStateNormal];
        [self.paramater setValue:@(1) forKey:@"type"];
    }
}

#pragma mark - 获取地址详细信息
-(void)fetchAddressDetailWithURL:(NSString *)url{
    
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfo:url parameters:nil success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            NSDictionary *dic = responseObject[@"data"];
            weakSelf.nameTF.text = dic[@"truename"];
            weakSelf.phoneNumTF.text = dic[@"mobile"];
            weakSelf.cityTF.text = [NSString stringWithFormat:@"%@",dic[@"provinces"]];
            weakSelf.addressTF.text = dic[@"address"];
            if ([dic[@"status"] integerValue] == 1){
                weakSelf.selectBtn.isClick = NO;
                [weakSelf selectedAction:weakSelf.selectBtn];
            }else{
                weakSelf.selectBtn.isClick = YES;
                [weakSelf selectedAction:weakSelf.selectBtn];
            }
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 添加收货地址
-(void)addShippingAddressWithURL:(NSString *)url parameter:(NSDictionary *)parameter{
    
    NSLog(@"parameter=%@",parameter);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:parameter success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] intValue] == 200) {
            [ShowMessage showMessage:responseObject[@"message"] duration:3];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 编辑地址
-(void)editShippingAddressWithURL:(NSString *)url paramater:(NSDictionary *)paramater{
    
    NSLog(@"parameter=%@",paramater);
    WeakSelf(weakSelf);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] intValue] == 200) {
            [ShowMessage showMessage:responseObject[@"message"] duration:3];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}



@end
