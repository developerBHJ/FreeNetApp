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



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveAddress.layer.cornerRadius = 5;
    self.saveAddress.layer.masksToBounds = YES;
    self.zipTF.delegate = self;
    self.zipTF.returnKeyType = UIReturnKeyDone;

    
    NSLog(@"%@",self.addressId);
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



#pragma mark - TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.view endEditing:YES];
    return YES;
}



#pragma mark - 添加收货地址
-(void)addShippingAddressWithURL:(NSString *)url{


}



#pragma mark - 编辑地址
-(void)editShippingAddressWithURL:(NSString *)url{

    

}




@end
