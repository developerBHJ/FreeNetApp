//
//  IndianaIslandViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "IndianaIslandViewController.h"
#import "AnswerViewController.h"
#import "isLandCell.h"

#define kChangePriceUrl @"http://192.168.0.254:4004/indiana/hit_price"
#define kUserInfo @"http://192.168.0.254:4004/users/profile"

typedef NS_ENUM(NSInteger,rightViewState){
    
    rightViewStateWithJoyBeans,
    rightViewStateWithAnswers,
    rightViewStateWithShare
};

@interface IndianaIslandViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong)JXButton *selectBtn;
@property (nonatomic,strong)UITableView *leftView;
@property (nonatomic,strong)NSMutableDictionary *isLandData;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,assign)rightViewState viewState;
@property (nonatomic,strong)NSMutableDictionary *paramater;
@property (nonatomic,strong)UILabel *balanceLabel;

@end

@implementation IndianaIslandViewController

-(instancetype)initWithID:(IndianaDetailModel *)model{
    
    self = [super init];
    if (self) {
        self.detailModel = model;
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    
    [self.view addSubview:self.leftView];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.leftView.frame), 0, kScreenWidth / 4 * 3, kScreenHeight)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    self.navigationItem.title = @"夺宝岛";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    [self.leftView registerNib:[UINib nibWithNibName:@"isLandCell" bundle:nil] forCellReuseIdentifier:@"isLandCell"];
    
    [self.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self tableView:self.leftView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
}
#pragma mark - 懒加载
-(UITableView *)leftView{
    
    if (!_leftView) {
        _leftView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 4, kScreenHeight) style:UITableViewStyleGrouped];
        _leftView.delegate = self;
        _leftView.dataSource = self;
        _leftView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
        _leftView.separatorColor = [UIColor colorWithHexString:@"#cdcdcd"];
        _leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftView;
}

-(NSMutableDictionary *)isLandData{
    
    if (!_isLandData) {
        _isLandData = [NSMutableDictionary new];
    }
    return _isLandData;
}

-(NSMutableDictionary *)paramater{
    
    if (!_paramater) {
        _paramater = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.detailModel.id,@"lid", nil];
    }
    return _paramater;
}
#pragma mark - 自定义
-(void)getData{
    
    //获取个人信息
    [self.paramater setValue:@"1" forKey:@"userId"];
    [self requestUserInfo:kUserInfo paramater:self.paramater];
    
    AnswerViewController *answerVC = [[AnswerViewController alloc]init];
    PersonerGroup *model = [[PersonerGroup alloc]initWithTitle:@"欢乐豆降价" image:@"beans_gray" subTitle:@"beans_red" toViewController:nil];
    model.isSelected = NO;
    PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"答题降价" image:@"answer_gray" subTitle:@"answer_red" toViewController:answerVC];
    model_1.isSelected = NO;
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"分享降价" image:@"share_gray" subTitle:@"share_red" toViewController:nil];
    model_2.isSelected = NO;
    NSArray *leftData = [NSArray arrayWithObjects:model,model_1,model_2, nil];
    
    [self.isLandData setObject:leftData forKey:@"leftData"];
    PersonerGroup *model_3 = [[PersonerGroup alloc]initWithTitle:@"新浪微博" image:@"sinaWeibo" subTitle:nil toViewController:nil];
    PersonerGroup *model_4 = [[PersonerGroup alloc]initWithTitle:@"微信" image:@"webChart" subTitle:nil toViewController:nil];
    PersonerGroup *model_5 = [[PersonerGroup alloc]initWithTitle:@"微信朋友圈" image:@"webChartCircle" subTitle:nil toViewController:nil];
    PersonerGroup *model_6 = [[PersonerGroup alloc]initWithTitle:@"QQ好友" image:@"QQ" subTitle:nil toViewController:nil];
    NSArray *shareData = [NSArray arrayWithObjects:model_3,model_4,model_5,model_6, nil];
    [self.isLandData setObject:shareData forKey:@"share"];
}

// 分享
-(void)share:(UIBarButtonItem *)sender{
    
    [[BHJTools sharedTools]showShareView];
}



-(void)setRightView{
    
    for (UIView *view in self.backView.subviews) {
        [view removeFromSuperview];
    }
    if (self.viewState == rightViewStateWithJoyBeans) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, MainScreen_height / 10.7, kScreenWidth / 4, 20)];
        titleLabel.text = @"您账户剩余:";
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        titleLabel.textColor = [UIColor colorWithHexString:@"#696969"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, MainScreen_height / 10.7, kScreenWidth / 3, 20)];
        
        CGFloat coin = [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_coin" ] floatValue];
        NSString *content = [NSString stringWithFormat:@"%.2f欢乐豆",coin];
        
        self.balanceLabel.textAlignment = NSTextAlignmentLeft;
        [self.balanceLabel setFont:[UIFont systemFontOfSize:18]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:content];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(content.length - 3, 3)];
        self.balanceLabel.attributedText = str;
        self.balanceLabel.textColor = [UIColor colorWithHexString:@"#e4504b"];
        [self.backView addSubview:titleLabel];
        [self.backView addSubview:self.balanceLabel];
        
        UIButton *fireBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:@"我要砸价" image:nil selector:@selector(fireAction:) Frame:CGRectMake(25, MainScreen_height / 6.68, MainScreen_width / 3.76, MainScreen_height / 18.9) viewController:self selectedImage:nil tag:200];
        [fireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [fireBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        fireBtn.backgroundColor = [UIColor colorWithHexString:@"#e34a44"];
        fireBtn.cornerRadius = 4;
        [self.backView addSubview:fireBtn];
        UIButton *rechargeBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:@"马上充值" image:nil selector:@selector(fireAction:) Frame:CGRectMake(CGRectGetMaxX(fireBtn.frame) + 20, MainScreen_height / 6.68, MainScreen_width / 3.76, MainScreen_height / 18.9) viewController:self selectedImage:nil tag:201];
        [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        rechargeBtn.backgroundColor = [UIColor colorWithHexString:@"#62b44d"];
        rechargeBtn.cornerRadius = 4;
        [self.backView addSubview:rechargeBtn];
        UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(rechargeBtn.frame) + 20, MainScreen_width / 1.68, MainScreen_height / 18.9)];
        alertLabel.textColor = [UIColor lightGrayColor];
        alertLabel.text = @"每次砸价扣除10欢乐豆，价格降低0.1元，每天仅可砸一次哦！";
        alertLabel.borderColor = [UIColor colorWithHexString:@"#e5e5e5"];
        alertLabel.borderWidth = 1;
        alertLabel.cornerRadius = 4;
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.numberOfLines = 2;
        alertLabel.textColor = [UIColor colorWithHexString:@"#bebebe"];
        [alertLabel setFont:[UIFont systemFontOfSize:12]];
        [self.backView addSubview:alertLabel];
    }else if (self.viewState == rightViewStateWithAnswers){
        UIButton *starBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:@"开始答题" image:nil selector:@selector(fireAction:) Frame:CGRectMake(MainScreen_width / 4.15, MainScreen_height / 11.36, CGRectGetWidth(self.backView.frame) - MainScreen_width / 4.15 * 2, MainScreen_height / 18.9) viewController:self selectedImage:nil tag:202];
        [self.backView addSubview:starBtn];
        starBtn.backgroundColor = [UIColor colorWithHexString:@"#e34a44"];
        [starBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [starBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        starBtn.cornerRadius = 4;
        UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(25, MainScreen_height / 5.57, MainScreen_width / 1.68, MainScreen_height / 18.9)];
        content.textColor = [UIColor lightGrayColor];
        content.text = @"每过一关降价¥0.01元，每通关一次降价¥0.2元";
        content.borderColor = [UIColor colorWithHexString:@"#e5e5e5"];
        content.borderWidth = 1;
        content.cornerRadius = 4;
        content.textAlignment = NSTextAlignmentCenter;
        content.numberOfLines = 2;
        content.textColor = [UIColor colorWithHexString:@"#bebebe"];
        [content setFont:[UIFont systemFontOfSize:12]];
        [self.backView addSubview:content];
    }else{
        [self creatBtn];
    }
}


-(void)creatBtn{
    
    NSArray *shareArr = [self.isLandData objectForKey:@"share"];
    CGFloat btnWidth = (CGRectGetWidth(self.backView.frame) - 63) / 3;
    CGFloat btnHight = MainScreen_height / 8;
    for (int i = 0; i < shareArr.count; i ++) {
        PersonerGroup *model = shareArr[i];
        if (i < 3) {
            UIButton *shareBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:model.title image:model.imageName selector:@selector(fireAction:) Frame:CGRectMake(30 + btnWidth * i,MainScreen_height / 12.6, btnWidth, btnHight) viewController:self selectedImage:nil tag:300 + i];
            [shareBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleTop imageTitleSpace:25];
            [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
            [self.backView addSubview:shareBtn];
        }else if (3 <= i && i < 6){
            UIButton *shareBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:model.title image:model.imageName selector:@selector(fireAction:) Frame:CGRectMake(30 + btnWidth * (i - 3),MainScreen_height / 12.6 + btnHight, btnWidth, btnHight) viewController:self selectedImage:nil tag:300 + i];
            [shareBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleTop imageTitleSpace:25];
            [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
            
            [self.backView addSubview:shareBtn];
        }else{
            UIButton *shareBtn = [[BHJTools sharedTools]creatSystomButtonWithTitle:model.title image:model.imageName selector:@selector(fireAction:) Frame:CGRectMake(30 + btnWidth * (i - 6),MainScreen_height / 12.6 + btnHight * 2, btnWidth, btnHight) viewController:self selectedImage:nil tag:300 + i];
            [shareBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleTop imageTitleSpace:25];
            [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
            [self.backView addSubview:shareBtn];
        }
    }
}

//  按钮的回调方法
-(void)fireAction:(UIButton *)sender{
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    NSLog(@"tag:%ld",(long)sender.tag);
    switch (sender.tag) {
        case 200:{
            //一天之内砸价一次
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSDate *now = [NSDate date];
            NSDate *agoDate = [userDefault objectForKey:@"nowDate"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *ageDateString = [dateFormatter stringFromDate:agoDate];
            NSString *nowDateString = [dateFormatter stringFromDate:now];
            if ( [ageDateString isEqualToString:nowDateString]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"每天仅能砸价一次哦";
                [hud hideAnimated:YES afterDelay:2];
            }else{
                CGFloat banlance = [[self.balanceLabel.text substringToIndex:self.balanceLabel.text.length - 3] floatValue];
                NSLog(@"banlance=%.2f",banlance);
                if (banlance >= 10) {
                    [self changePriceWithBean:kChangePriceUrl paramater:self.paramater];
                }
            }
        }
            break;
        case 201:{
            RechargeRecordViewController *rechargeVC = [[RechargeRecordViewController alloc]init];
            [rechargeVC setTopView];
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }
            break;
        case 202:{
            AnswerViewController *answerVC = [[AnswerViewController alloc]init];
            answerVC.model = self.detailModel;
            [self.navigationController pushViewController:answerVC animated:YES];
        }
            break;
        case 300:{
            //            [[BHJTools sharedTools]shareWebPageToPlatformType:UMSocialPlatformType_Sina withUrl:@"http://dev.umeng.com/social/ios/quick-integration?spm=0.0.0.0.zzF6BA#4_1"];
        }
            break;
        case 301:{
            //            [[BHJTools sharedTools]shareWebPageToPlatformType:UMSocialPlatformType_WechatSession withUrl:@"http://dev.umeng.com/social/ios/quick-integration?spm=0.0.0.0.zzF6BA#4_1"];
        }
            break;
        case 302:{
            //            [[BHJTools sharedTools]shareWebPageToPlatformType:UMSocialPlatformType_WechatFavorite withUrl:@"http://dev.umeng.com/social/ios/quick-integration?spm=0.0.0.0.zzF6BA#4_1"];
        }
            break;
        case 303:{
            //            [[BHJTools sharedTools]shareWebPageToPlatformType:UMSocialPlatformType_QQ withUrl:@"http://dev.umeng.com/social/ios/quick-integration?spm=0.0.0.0.zzF6BA#4_1"];
        }
            break;
        case 304:{
            //            [[BHJTools sharedTools]shareWebPageToPlatformType:UMSocialPlatformType_Renren withUrl:@"http://dev.umeng.com/social/ios/quick-integration?spm=0.0.0.0.zzF6BA#4_1"];
        }
            break;
        case 305:{
            //            [[BHJTools sharedTools]shareWebPageToPlatformType:UMSocialPlatformType_TencentWb withUrl:@"http://dev.umeng.com/social/ios/quick-integration?spm=0.0.0.0.zzF6BA#4_1"];
        }
            break;
            
        case 306:{
            //            [[BHJTools sharedTools]shareWebPageToPlatformType:UMSocialPlatformType_Sms withUrl:@"http://dev.umeng.com/social/ios/quick-integration?spm=0.0.0.0.zzF6BA#4_1"];
        }
            break;
        default:
            break;
    }
}


/**
 欢乐豆砸价
 
 @param url 砸价URL
 @param paramater 参数
 */
-(void)changePriceWithBean:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        NSInteger status = [responseObject[@"status"] integerValue];
        if (status == 200) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weak.view animated:YES];
            hud.label.text = responseObject[@"message"];
            [hud hideAnimated:YES afterDelay:2];
            NSDate *nowDate = [NSDate date];
            NSUserDefaults *dataUser = [NSUserDefaults standardUserDefaults];
            [dataUser setObject:nowDate forKey:@"nowDate"];
            [dataUser synchronize];
            [weak.paramater setValue:@"1" forKey:@"userId"];
            [weak requestUserInfo:kUserInfo paramater:self.paramater];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取用户信息
 
 @param url 用户信息URL
 @param paramater 参数
 */
-(void)requestUserInfo:(NSString *)url paramater:(NSDictionary *)paramater{
    
    WeakSelf(weak);
    [[BHJNetWorkTools sharedNetworkTool]loadDataInfoPost:url parameters:paramater success:^(id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            [weak.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            
            NSDictionary *user = responseObject[@"data"];
            
            CGFloat coin = [user[@"coin"] floatValue];
            CGFloat gold = [user[@"gold"] floatValue];
            [[NSUserDefaults standardUserDefaults]setValue:@(coin) forKey:@"user_coin"];
            [[NSUserDefaults standardUserDefaults]setValue:@(gold) forKey:@"user_gold"];

            NSString *banlance = [NSString stringWithFormat:@"%.2f欢乐豆",coin];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:banlance];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(banlance.length - 3, 3)];
            weak.balanceLabel.attributedText = str;
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - 协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = [self.isLandData objectForKey:@"leftData"];
    return [tableView showMessage:@"" byDataSourceCount:arr.count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    isLandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"isLandCell" forIndexPath:indexPath];
    NSArray *arr = [self.isLandData objectForKey:@"leftData"];
    cell.model = arr[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return MainScreen_height / 6.34;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        self.viewState = rightViewStateWithJoyBeans;
        [self setRightView];
    }else if (indexPath.row == 1){
        self.viewState = rightViewStateWithAnswers;
        [self setRightView];
    }else{
        self.viewState = rightViewStateWithShare;
        [self setRightView];
    }
}
#pragma mark -

@end
