//
//  FreeNetUserDelegateViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "FreeNetUserDelegateViewController.h"

@interface FreeNetUserDelegateViewController ()

@end

@implementation FreeNetUserDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"立免网";
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -15, kScreenWidth, kScreenHeight)];
    backView.image = [[UIImage imageNamed:@"注册协议.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:backView];
    
}



@end
