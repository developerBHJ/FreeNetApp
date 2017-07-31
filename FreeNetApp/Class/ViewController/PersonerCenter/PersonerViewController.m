//
//  PersonerViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerViewController.h"
#import "PersonerCell_0.h"
#import "LoginViewController.h"
#import "PersonerGroup.h"
#import "PersonerCell.h"
#import "UIButton+BHJButtonCategory.h"

#import "PersonerSettingViewController.h"
#import "UserLevelViewController.h"

#import "PersonerFreeViewController.h"
#import "PersonerIndianaViewController.h"
#import "RechargeRecordViewController.h"
#import "PersonerExchangeViewController.h"

#import "MyOrderViewController.h"
#import "InvitationRecordViewController.h"
#import "AddressViewController.h"

#import "MessageCenterViewController.h"
#import "DailyRecommendationViewController.h"
#import "TopfunViewController.h"
#import "CustomerServiceViewController.h"

#import "BHJScanQRViewController.h"

@interface PersonerViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UITableView *personTableView;
@property (nonatomic,strong)NSMutableArray *personerData;
@property (nonatomic,strong)NSMutableArray *groupData;
@property (nonatomic,strong)NSMutableArray *segementArray;
@end

@implementation PersonerViewController



#pragma mark - Init
-(UITableView *)personTableView{
    
    if (!_personTableView) {
        _personTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _personTableView.dataSource = self;
        _personTableView.delegate = self;
        _personTableView.backgroundColor = HWColor(241, 241, 241, 1.0);
    }
    return _personTableView;
}

-(NSMutableArray *)personerData{
    
    if (!_personerData) {
        _personerData = [NSMutableArray new];
    }
    return _personerData;
}


-(NSMutableArray *)groupData{
    
    if (!_groupData) {
        _groupData = [NSMutableArray new];
    }
    return _groupData;
}

-(NSMutableArray *)segementArray{
    
    if (!_segementArray) {
        _segementArray = [NSMutableArray new];
        
        PersonerFreeViewController *freeVC = [[PersonerFreeViewController alloc]init];
        freeVC.viewControllerStatu = BHJViewControllerStatuFree;
        PersonerFreeViewController *freeVC1 = [[PersonerFreeViewController alloc]init];
        freeVC1.viewControllerStatu = BHJViewControllerStatuIndiana;
        PersonerFreeViewController *freeVC2 = [[PersonerFreeViewController alloc]init];
        freeVC2.viewControllerStatu = BHJViewControllerStatuSpecial;
        PersonerFreeViewController *freeVC3 = [[PersonerFreeViewController alloc]init];
        freeVC3.viewControllerStatu = BHJViewControllerStatuCoupon;
        PersonerFreeViewController *freeVC4 = [[PersonerFreeViewController alloc]init];
        freeVC4.viewControllerStatu = BHJViewControllerStatuOpen;
        PersonerGroup *model_0 = [[PersonerGroup alloc]initWithTitle:@"免费" image:@"myFree" subTitle:nil toViewController:freeVC];
        PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"夺宝" image:@"myIndiana" subTitle:nil toViewController:freeVC1];
        PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"特价" image:@"mySpecial" subTitle:nil toViewController:freeVC2];
        PersonerGroup *model_3 = [[PersonerGroup alloc]initWithTitle:@"现金券" image:@"myExchange" subTitle:nil toViewController:freeVC3];
        PersonerGroup *model_4 = [[PersonerGroup alloc]initWithTitle:@"开饭啦" image:@"myOpen" subTitle:nil toViewController:freeVC4];
        
        [_segementArray addObject:model_0];
        [_segementArray addObject:model_1];
        [_segementArray addObject:model_2];
        [_segementArray addObject:model_3];
        [_segementArray addObject:model_4];
        
    }
    return _segementArray;
}



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    [self.personTableView registerNib:[UINib nibWithNibName:@"PersonerCell_0" bundle:nil] forCellReuseIdentifier:@"PersonerCell_0"];
    [self.personTableView registerNib:[UINib nibWithNibName:@"PersonerCell" bundle:nil] forCellReuseIdentifier:@"PersonerCell"];
    [self.personTableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.personTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    [self setView];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - NSNotification

#pragma mark - 自定义
-(void)setView{
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(personerSetting:)];
    //  UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"scan"] style:UIBarButtonItemStylePlain target:self action:@selector(scanAction:)];
    
    //把右侧的两个按钮添加到rightBarButtonItem
    BOOL loginStatus = [[NSUserDefaults standardUserDefaults]boolForKey:@"user_login"];
    if (loginStatus == YES) {
        [self setGroupData];
    }else{
        [self setGroupDataWithSignOut];
    }
    self.navigationItem.rightBarButtonItems = @[item1];
}

-(void)setGroupData{
    
    MessageCenterViewController *messageVC = [[MessageCenterViewController alloc]init];
    PersonerGroup *model_0 = [[PersonerGroup alloc]initWithTitle:@"消息中心" image:@"myMessage" subTitle:nil toViewController:messageVC];
    
    // DailyRecommendationViewController *recommendationVC = [[DailyRecommendationViewController alloc]init];
    // PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"每日推荐" image:@"recommend" subTitle:nil toViewController:recommendationVC];
    
    TopfunViewController *topFunVC = [[TopfunViewController alloc]init];
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"乐翻天" image:@"topFun" subTitle:@"玩游戏，好礼天天送" toViewController:topFunVC];
    
    CustomerServiceViewController *customerVC = [[CustomerServiceViewController alloc]init];
    PersonerGroup *model_3 = [[PersonerGroup alloc]initWithTitle:@"客服中心" image:@"customer" subTitle:nil toViewController:customerVC];
    [self.groupData removeAllObjects];
    [self.groupData addObject:model_0];
    //  [self.groupData addObject:model_1];
    [self.groupData addObject:model_2];
    [self.groupData addObject:model_3];
    
    MyOrderViewController *orderVC = [[MyOrderViewController alloc]init];
    //  MyExchangeViewController *myExchangeVC = [[MyExchangeViewController alloc]init];
    RechargeRecordViewController *rechargeRecordVC = [[RechargeRecordViewController alloc]init];
    PersonerExchangeViewController *exchangeRecordVC = [[PersonerExchangeViewController alloc]init];
    InvitationRecordViewController *invitationVC = [[InvitationRecordViewController alloc]init];
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    
    PersonerGroup *group_0 = [[PersonerGroup alloc]initWithTitle:@"我的关注" image:@"myCollection" subTitle:nil toViewController:orderVC];
    // PersonerGroup *group_1 = [[PersonerGroup alloc]initWithTitle:@"我的换货" image:@"exChange" subTitle:nil toViewController:myExchangeVC];
    PersonerGroup *group_2 = [[PersonerGroup alloc]initWithTitle:@"充值" image:@"reCharge" subTitle:@"385 元" toViewController:rechargeRecordVC];
    PersonerGroup *group_3 = [[PersonerGroup alloc]initWithTitle:@"兑换" image:@"exchangeRecord" subTitle:nil toViewController:exchangeRecordVC];
    PersonerGroup *group_4 = [[PersonerGroup alloc]initWithTitle:@"邀请记录" image:@"Invitation record" subTitle:@"300 欢乐豆" toViewController:invitationVC];
    PersonerGroup *group_5 = [[PersonerGroup alloc]initWithTitle:@"收货地址" image:@"address" subTitle:nil toViewController:addressVC];
    
    [self.personerData removeAllObjects];
    [self.personerData addObject:group_0];
    // [self.personerData addObject:group_1];
    [self.personerData addObject:group_2];
    [self.personerData addObject:group_3];
    [self.personerData addObject:group_4];
    [self.personerData addObject:group_5];
    [self.personTableView reloadData];
}

-(void)setGroupDataWithSignOut{
    
    
    MessageCenterViewController *messageVC = [[MessageCenterViewController alloc]init];
    // DailyRecommendationViewController *recommendationVC = [[DailyRecommendationViewController alloc]init];
    PersonerGroup *model_0 = [[PersonerGroup alloc]initWithTitle:@"消息中心" image:@"myMessage" subTitle:nil toViewController:messageVC];
    //PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"每日推荐" image:@"recommend" subTitle:nil toViewController:recommendationVC];
    [self.personerData removeAllObjects];
    [self.personerData addObject:model_0];
    //   [self.personerData addObject:model_1];
    
    
    CustomerServiceViewController *customerVC = [[CustomerServiceViewController alloc]init];
    PersonerGroup *model = [[PersonerGroup alloc]initWithTitle:@"客服中心" image:@"customer" subTitle:nil toViewController:customerVC];
    [self.groupData removeAllObjects];
    [self.groupData addObject:model];
    [self.personTableView reloadData];
}

// 个人设置
-(void)personerSetting:(UIBarButtonItem *)sender{
    
    PersonerSettingViewController *setVC = [[PersonerSettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}


-(void)addButtonToCell:(UITableViewCell *)cell{
    
    for (int i = 0; i < self.segementArray.count; i ++) {
        JXButton *btn = [JXButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnWidth = kScreenWidth / 5;
        [btn setFrame:CGRectMake(btnWidth* i, 7, btnWidth, CGRectGetHeight(cell.frame) - 10)];
        PersonerGroup *model = self.segementArray[i];
        [btn setImage:[[UIImage imageNamed:model.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setTitle:model.title forState:UIControlStateNormal];
        btn.tag = 2000 + i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
        [btn.imageView imageFillImageView];
        
        [btn addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
}



-(void)segementAction:(UIButton *)sender{
    
    if (user_login == NO) {
        
        [ShowMessage showMessage:@"请先登录" duration:3];
    }else{
        PersonerGroup *group = self.segementArray[sender.tag - 2000];
        BHJViewController *toVC = (BHJViewController *)group.viewController;
        toVC.navgationTitle = group.title;
        [self.navigationController pushViewController:toVC animated:YES];
    }
}

// 扫描二维码
-(void)scanAction:(UIBarButtonItem *)sender{
    
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 24;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 20;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 20;
    style.colorAngle = [UIColor whiteColor];
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    //添加一些扫码或相册结果处理
    BHJScanQRViewController *scanVC = [BHJScanQRViewController new];
    scanVC.style = style;
    
    scanVC.isQQSimulator = YES;
    scanVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanVC animated:YES];
}



#pragma mark - TableView 代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 110;
    }else if (indexPath.section == 1){
        return 61;
    }else{
        return 39;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 3 || section == 0) {
        return 1;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return 10;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        PersonerGroup *model = self.personerData[indexPath.row];
        [self.navigationController pushViewController:model.viewController animated:YES];
    }else if (indexPath.section == 3){
        PersonerGroup *model = self.groupData[indexPath.row];
        [self.navigationController pushViewController:model.viewController animated:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        if (user_login == YES) {
            return self.personerData.count;
        }else{
            return 1;
        }
    }else if (section == 3){
        if (user_login == YES) {
            return self.groupData.count;
        }else{
            return 1;
        }
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        PersonerCell_0 *firstCell = [tableView dequeueReusableCellWithIdentifier:@"PersonerCell_0" forIndexPath:indexPath];
        firstCell.delegate = self;
        firstCell.user_headImage.tag = 1001;
        firstCell.lev_butn.tag = 1002;
        firstCell.edtiBtn.tag = 1003;
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return firstCell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addButtonToCell:cell];
        return cell;
    }else{
        PersonerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonerCell" forIndexPath:indexPath];
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.leftMargin.constant = 12.5;
                cell.leftSpace.constant = 12.5;
            }
            PersonerGroup *model = self.personerData[indexPath.row];
            [cell setCellWithModel:model];
        }else if (indexPath.section == 3){
            PersonerGroup *model = self.groupData[indexPath.row];
            [cell setCellWithModel:model];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
#pragma mark - BaseTableViewCellDelegate
-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index{
    
    switch (button.tag) {
        case 1001:{
            if (user_login == YES) {
                [self setUserHeadImage];
            }else{
                button.selected = YES;
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        }
            break;
        case 1002:{
            UserLevelViewController *userLevelVC = [[UserLevelViewController alloc]init];
            [self.navigationController pushViewController:userLevelVC animated:YES];
        }
            break;
        case 1003:
            NSLog(@"editting");
            break;
        default:
            break;
    }
}



#pragma mark - 调用系统相册
-(void)setUserHeadImage{
    
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
    imagePickerVC.delegate = self;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:imagePickerVC animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    PersonerCell_0 *cell = [self.personTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImage *selectImage = [info[UIImagePickerControllerOriginalImage] clipImageWithRadius:cell.user_headImage.width / 2];
    [cell.user_headImage setImage:selectImage forState:(UIControlStateNormal)];
    [self.personTableView reloadData];
    
    NSData *imageData = UIImageJPEGRepresentation(selectImage, 0.3);
    
    //上传图片到阿里云
    [self changeHeadImageWithURL:API_URL(@"/uploader/avatar") Data:imageData];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 上传头像到阿里云
-(void)changeHeadImageWithURL:(NSString *)url Data:(NSData *)data{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
    [parameter setValue:base64Str forKey:@"data"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 200) {
            
            //删除旧的阿里云图片
            [self deletePictureWithURL:API_URL(@"/uploader/erase") ImageName:result[@"data"][@"name"] ImageURL:[self InterceptionOfString:result[@"data"][@"url"] Interception:@"?"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}

#pragma mark - 删除图片接口
-(void)deletePictureWithURL:(NSString *)url ImageName:(NSString *)imageName ImageURL:(NSString *)imageUrl{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_avatar_name forKey:@"name"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([result[@"status"] intValue] == 200) {
            
            //更新新的图片
            [self updatePictureWithURL:API_URL(@"/users/avatar") ImageName:imageName ImageURL:imageUrl];
        }else{
            [ShowMessage showMessage:@"失败" duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}

#pragma mark - 更新头像接口
-(void)updatePictureWithURL:(NSString *)url ImageName:(NSString *)imageName ImageURL:(NSString *)imageUrl{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"user_id"];
    [parameter setValue:imageUrl forKey:@"avatar_url"];
    [parameter setValue:imageName forKey:@"avatar_name"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        if ([result[@"status"] intValue] == 200) {
            [[NSUserDefaults standardUserDefaults] setValue:imageUrl forKey:@"user_avatar_url"];
        }else{
            
            [ShowMessage showMessage:result[@"message"] duration:3];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}

#pragma mark - 截取指定字符串
-(NSString *)InterceptionOfString:(NSString *)str Interception:(NSString *)interception{
    
    NSString *currentStr = str;
    NSRange range = [currentStr rangeOfString:interception];
    NSString *newStr = [currentStr substringToIndex:range.location];
    return newStr;
}

@end
