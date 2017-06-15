//
//  BHJNavigationViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJNavigationViewController.h"

@interface BHJNavigationViewController ()

@end

@implementation BHJNavigationViewController

+(void)initialize{

    UINavigationBar *item = [UINavigationBar appearance];
    item.barTintColor = [UIColor colorWithHexString:@"#e4504b"];
    item.tintColor = [UIColor whiteColor];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}


- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
