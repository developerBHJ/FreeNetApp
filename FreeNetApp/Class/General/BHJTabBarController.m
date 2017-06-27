//
//  BHJTabBarController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJTabBarController.h"
#import "FreeViewController.h"
#import "IndianaViewController.h"
#import "SpecialViewController.h"
#import "CouponViewController.h"
#import "PersonerViewController.h"

#import "BerserkViewController.h"
#import "BerserkHistoryViewController.h"
@interface BHJTabBarController ()

@end

@implementation BHJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)setupChildViewControllers{
    
    FreeViewController *freeVC = [[FreeViewController alloc]init];
    [self childViewController:freeVC imageName:@"free_nomal" selectedImageName:@"free_selected" withTitle:@"免费"];
    
    SpecialViewController *specialVC = [[SpecialViewController alloc]init];
    [self childViewController:specialVC imageName:@"special_nomal" selectedImageName:@"special_selected" withTitle:@"特价"];
    
    IndianaViewController *indianVC = [[IndianaViewController alloc]init];
    [self childViewController:indianVC imageName:@"indiana_nomal" selectedImageName:@"indiana_selected" withTitle:@"夺宝"];
    
    CouponViewController *couponVC = [[CouponViewController alloc]init];
    [self childViewController:couponVC imageName:@"cash_nomal" selectedImageName:@"cash_selected" withTitle:@"现金券"];
    
    PersonerViewController *personalVC = [[PersonerViewController alloc]init];
    [self childViewController:personalVC imageName:@"user_nomal" selectedImageName:@"user_selected" withTitle:@"我"];
}


- (void)childViewController:(UIViewController *)vc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName withTitle:(NSString *)title
{
    // 设置子控制器的文字
    vc.title = title; // 同时设置tabbar和navigationBar的文字
    vc.tabBarItem.title = title; // 设置tabbar的文字
    vc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123,1.0);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#e4504b"];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //childVc.view.backgroundColor = HWRandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    BHJNavigationViewController *nav = [[BHJNavigationViewController alloc] initWithRootViewController:vc];
    // 添加为子控制器
    [self addChildViewController:nav];
}




@end
