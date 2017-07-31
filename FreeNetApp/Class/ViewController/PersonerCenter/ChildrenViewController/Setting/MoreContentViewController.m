//
//  MoreContentViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "MoreContentViewController.h"
#import "MoreCell.h"
#import "MoreCell_1.h"
#import "AboutFreeNetViewController.h"
#import "ShareViewController.h"

@interface MoreContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *moreTableView;
@property (nonatomic,strong)NSMutableArray *moreData;
@property (nonatomic,strong)UIView *alertView;

@end

@implementation MoreContentViewController
#pragma mark >>>>> 懒加载
-(NSMutableArray *)moreData{
    
    if (!_moreData) {
        _moreData = [NSMutableArray new];
    }
    return _moreData;
}

-(UITableView *)moreTableView{
    
    if (!_moreTableView) {
        _moreTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, kScreenHeight) style:UITableViewStyleGrouped];
        _moreTableView.dataSource = self;
        _moreTableView.delegate = self;
    }
    return _moreTableView;
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"更多";
    
    [self setViewWithData];
    [self.moreTableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:@"MoreCell"];
    [self.moreTableView registerNib:[UINib nibWithNibName:@"MoreCell_1" bundle:nil] forCellReuseIdentifier:@"MoreCell_1"];
    [self.view addSubview:self.moreTableView];
}
#pragma mark - 自定义
-(void)setViewWithData{
    
    PersonerGroup *model_0 = [[PersonerGroup alloc]initWithTitle:@"消息提醒" image:nil subTitle:nil toViewController:nil];
   // PersonerGroup *model_1 = [[PersonerGroup alloc]initWithTitle:@"分享设置" image:nil subTitle:nil toViewController:nil];
    PersonerGroup *model_2 = [[PersonerGroup alloc]initWithTitle:@"清空缓存" image:nil subTitle:@"829.80k" toViewController:nil];
    NSMutableArray *group1 = [NSMutableArray arrayWithObjects:model_0,model_2, nil];
    PersonerGroup *model_3 = [[PersonerGroup alloc]initWithTitle:@"支付帮助" image:nil subTitle:nil toViewController:nil];
    PersonerGroup *model_5 = [[PersonerGroup alloc]initWithTitle:@"关于立免" image:nil subTitle:nil toViewController:nil];
    
    NSMutableArray *group2 = [NSMutableArray arrayWithObjects:model_3,model_5, nil];
    
    [self.moreData addObject:group1];
    [self.moreData addObject:group2];
}

//  提示窗消失
-(void)dismissView:(UITapGestureRecognizer *)sender{

    [self.alertView removeFromSuperview];
}

#pragma mark - Table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.moreData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = self.moreData[section];
    return array.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0) {
        MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        NSArray *array = self.moreData[indexPath.section];
        PersonerGroup *model = array[indexPath.row - 1];
        [cell setCellWithModel:model];
        return cell;
    }else{
        MoreCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell_1" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        
        if (indexPath.section == 0) {
            cell.titleLabel.text = @"仅WiFi下显示产品图片";
            cell.leftSwitch.tag = 1000;
        }else{
            cell.titleLabel.text = @"意见反馈";
            cell.leftSwitch.tag = 1001;
        }
        cell.delegate = self;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenHeight / 12.9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1){
        return 0.1;
    }else{
        return 15;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 15;
    }else{
        return 0.1;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 2) {
                ShareViewController *shareVC = [[ShareViewController alloc]init];
                shareVC.navgationTitle = @"分享设置";
                [self.navigationController pushViewController:shareVC animated:YES];
            }else if(indexPath.row == 3){
                
                [self ClearTheCache];
            }
        }
            break;
        case 1:
        {
             if (indexPath.row == 2){
                AboutFreeNetViewController *aboutVC = [[AboutFreeNetViewController alloc]init];
                aboutVC.navgationTitle = @"关于立免网";
                [self.navigationController pushViewController:aboutVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
}



#pragma mark >>>>>> BaseTableViewCell 代理
-(void)BaseCellMethodWithViewController:(UIViewController *)viewController switch:(UISwitch *)sender cellRow:(NSIndexPath *)cellRow{
    
    switch (sender.tag) {
        case 1000:
        {
            if (sender.on) {
                NSLog(@"显示图片");
            }else{
                NSLog(@"显示图片11111");
            }
        }
            break;
        case 1001:
        {
            if (sender.on) {
                NSLog(@"意见反馈");
            }else{
                NSLog(@"意见反馈222");
            }
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - 清除缓存文件
-(void)ClearTheCache{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    CGFloat  folderSize = 0;
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            NSDictionary *dic =[fileManager attributesOfItemAtPath:absolutePath error:nil];
            NSString *str = dic[NSFileSize];
            folderSize += [str floatValue];
        }
        folderSize = folderSize/1024.0/1024.0;
        
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        
        int fileSize = (int)folderSize;
        //清理缓存
        if (fileSize > 0) {
            
            for (NSString *fileName in childerFiles) {
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
            [[SDImageCache sharedImageCache] cleanDisk];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"已清理缓存%dM",fileSize] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"无缓存文件" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
}


#pragma mark - 版本更新提示框（无用）
-(UIView *)alertView{
    
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:self.view.frame];
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.text = @"当前已经是最新版本了！";
        [contentLabel setFrame:CGRectMake(5, 5, kScreenWidth / 1.88 - 10, kScreenHeight / 11.7 - 10)];
        [contentLabel setFont:[UIFont systemFontOfSize:12]];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.textColor = [UIColor whiteColor];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenWidth / 1.88) / 2, (kScreenHeight - kScreenHeight / 11.7) / 2, kScreenWidth / 1.88, kScreenHeight / 11.7)];
        backView.backgroundColor = [UIColor blackColor];
        backView.layer.cornerRadius = 10;
        backView.layer.masksToBounds = YES;
        [backView addSubview:contentLabel];
        [_alertView addSubview:backView];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView:)];
        [_alertView addGestureRecognizer:tapGR];
    }
    return _alertView;
}


@end
