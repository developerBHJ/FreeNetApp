//
//  PersonerSettingViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerSettingViewController.h"
#import "ModifyPwdViewController.h"
#import "ModifyUserNameViewController.h"
#import "ModifyPayPwdViewController.h"
#import "VerificationViewController.h"
#import "PersonerCell.h"
#import "AddressViewController.h"
#import "MoreContentViewController.h"

#import "LoginViewController.h"
@interface PersonerSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *personerSettingTableView;
@property (nonatomic,strong)NSMutableArray *Elements;

@end

@implementation PersonerSettingViewController



#pragma mark - Init
-(UITableView *)personerSettingTableView{
    
    if (!_personerSettingTableView) {
        _personerSettingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _personerSettingTableView.delegate = self;
        _personerSettingTableView.dataSource = self;
        _personerSettingTableView.scrollEnabled  = NO;
    }
    return _personerSettingTableView;
}

-(NSMutableArray *)Elements{
    
    if (!_Elements) {
        _Elements = [NSMutableArray new];
    }
    return _Elements;
}



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    [self.view addSubview:self.personerSettingTableView];
    [self.personerSettingTableView registerNib:[UINib nibWithNibName:@"PersonerCell" bundle:nil] forCellReuseIdentifier:@"PersonerCell"];
    
    UIButton *signOutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [signOutBtn setFrame:CGRectMake(10, kScreenHeight - kScreenHeight / 3, kScreenWidth - 20, kScreenHeight / 12)];
    signOutBtn.tag = 10086;
    [signOutBtn setTintColor:[UIColor whiteColor]];
    [signOutBtn setTitle:@"退出账户" forState:UIControlStateNormal];
    [signOutBtn setBackgroundColor:[UIColor colorWithHexString:@"#e4504b"]];
    signOutBtn.layer.cornerRadius = 5;
    signOutBtn.layer.masksToBounds = YES;
    [self.view addSubview:signOutBtn];
    [signOutBtn addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
    [self setViewWithData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    NSString *loginStyle = [[NSUserDefaults standardUserDefaults]valueForKey:@"login"];
    if (![loginStyle isEqualToString:@"succeed"]) {
            //未登录
        UIButton *button = [self.view viewWithTag:10086];
        button.hidden = YES;
    }
}



-(void)setViewWithData{

    //支付密码
    ModifyPayPwdViewController *payPwdVC = [[ModifyPayPwdViewController alloc]init];
    //用户账户
    ModifyUserNameViewController *modifyUserNameVC = [[ModifyUserNameViewController alloc]init];
    //修改密码
    ModifyPwdViewController *modifyVC = [[ModifyPwdViewController alloc]init];
    //绑定手机
    VerificationViewController *verifyVC = [[VerificationViewController alloc]init];
    //收货地址
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    //更多
    MoreContentViewController *moreVC = [[MoreContentViewController alloc]init];
   
    
    PersonerGroup *model_0 = [[PersonerGroup alloc]initWithTitle:@"支付密码" image:@"payKey" subTitle:nil toViewController:payPwdVC];
    PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"账户名" image:@"0_1" subTitle:@"修改" toViewController:modifyUserNameVC];
    model_1.content = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_name"];
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"登陆密码" image:@"pwd" subTitle:@"修改" toViewController:modifyVC];
    PersonerGroup *model_3 = [[PersonerGroup alloc]initWithTitle:@"已绑定手机" image:@"myPhone" subTitle:@"更换" toViewController:verifyVC];
    model_3.content = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_phone"];
    PersonerGroup *model_4 = [[PersonerGroup alloc]initWithTitle:@"收货地址" image:@"address" subTitle:@"修改/添加" toViewController:addressVC];
    PersonerGroup *model_5 = [[PersonerGroup alloc]initWithTitle:@"更多" image:@"more" subTitle:nil toViewController:moreVC];
    [self.Elements addObject:model_0];
    [self.Elements addObject:model_1];
    [self.Elements addObject:model_2];
    [self.Elements addObject:model_3];
    [self.Elements addObject:model_4];
    [self.Elements addObject:model_5];
}



#pragma mark - Table Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return self.Elements.count - 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonerCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    cell.subTitle.textColor = [UIColor redColor];
    if (indexPath.section == 0) {
        PersonerGroup *model = self.Elements[0];
        [cell setCellWithModel:model];
    }else{
        PersonerGroup *model = self.Elements[indexPath.row + 1];
        [cell setCellWithModel:model];
        if (indexPath.row == 0 || indexPath.row == 2) {
            cell.contentLabel.hidden = NO;
        }else{
            if (indexPath.row == self.Elements.count - 2) {
                cell.leftSpace.constant = 17;
            }
            cell.contentLabel.hidden = YES;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (user_id) {
            //登录状态下
        if (indexPath.section == 0) {
            PersonerGroup *model = self.Elements[0];
            BHJViewController *toViewController = (BHJViewController *)model.viewController;
            [self.navigationController pushViewController:toViewController animated:YES];
            toViewController.navgationTitle = model.title;
        }else{
            PersonerGroup *model = self.Elements[indexPath.row + 1];
            BHJViewController *toViewController = (BHJViewController *)model.viewController;
            [self.navigationController pushViewController:toViewController animated:YES];
            toViewController.navgationTitle = model.title;
        }
    }else{
            //未登录状态下
        if (indexPath.section == 1 && indexPath.row == 4) {
            
               MoreContentViewController *moreVC = [[MoreContentViewController alloc]init];
                [self.navigationController pushViewController:moreVC animated:YES];
            }else{
                [ShowMessage showMessage:@"请先登录" duration:3];
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 16;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}



#pragma mark - 退出账户
-(void)signOut:(UIButton *)sender{
    
    [self logOutWithURL:API_URL(@"/sso/users/logout")];
}



#pragma mark - 退出账户响应
-(void)logOutWithURL:(NSString *)url{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:@{@"user_id":user_id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

        if ([result[@"status"] intValue] == 200) {
            NSLog(@"退出成功");
            [ShowMessage showMessage:@"退出成功" duration:3];
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"user_login"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_token"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_mobile"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_avatar_name"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_avatar_url"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_sex"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_nickname"];

            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }else{
            [ShowMessage showMessage:@"退出失败 请稍后再试" duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}



@end
