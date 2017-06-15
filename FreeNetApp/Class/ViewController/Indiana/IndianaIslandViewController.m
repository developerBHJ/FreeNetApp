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

@end

@implementation IndianaIslandViewController
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
    }
    return _leftView;
}

-(NSMutableDictionary *)isLandData{
    
    if (!_isLandData) {
        _isLandData = [NSMutableDictionary new];
    }
    return _isLandData;
}
#pragma mark - 自定义
-(void)getData{
    
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
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, MainScreen_height / 10.7, kScreenWidth / 3, 20)];
        NSString *content = @"3000欢乐豆";
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [contentLabel setFont:[UIFont systemFontOfSize:18]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:content];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(content.length - 3, 3)];
        contentLabel.attributedText = str;
        contentLabel.textColor = [UIColor colorWithHexString:@"#e4504b"];
        [self.backView addSubview:titleLabel];
        [self.backView addSubview:contentLabel];
        
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
            NSLog(@"我要砸价");
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
