//
//  AboutFreeNetViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AboutFreeNetViewController.h"
#import "FreeNetUserDelegateViewController.h"

@interface AboutFreeNetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end

@implementation AboutFreeNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

        
    
    
}


- (IBAction)UserAgreement:(UITapGestureRecognizer *)sender {
    
    FreeNetUserDelegateViewController *freeNetVC = [[FreeNetUserDelegateViewController alloc]init];
    [self.navigationController pushViewController:freeNetVC animated:YES];
}


- (IBAction)evaluate:(UITapGestureRecognizer *)sender {
    
    NSLog(@"给个好评吧");
}

@end
