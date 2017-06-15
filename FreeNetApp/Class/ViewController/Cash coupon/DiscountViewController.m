//
//  DiscountViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "DiscountViewController.h"
#import "discountDecriptionView.h"
@interface DiscountViewController ()

@property (nonatomic,strong)UIScrollView *backView;

@end

@implementation DiscountViewController
#pragma mark - 懒加载
-(UIScrollView *)backView{

    if (!_backView) {
        _backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64)];
        _backView.showsVerticalScrollIndicator = NO;
        _backView.showsHorizontalScrollIndicator = NO;
        _backView.bounces = NO;
        _backView.contentSize = CGSizeMake(0, kScreenHeight * 1.1);
        _backView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_backView];
    }
    return _backView;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
}

#pragma mark - 自定义
-(void)setUpViews{

    self.navigationItem.title = @"发优惠";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    discountDecriptionView *discountView = [discountDecriptionView shareDiscountDecriptionView];
    [discountView.cameraBtn addTarget:self action:@selector(pikerPhotos:) forControlEvents:UIControlEventTouchUpInside];
    discountView.frame = CGRectMake(5, 0, kScreenWidth - 10, kScreenHeight - 21);
    [self.backView addSubview:discountView];
//    [[BHJTools sharedTools]setViewWithTextField:discountView.couponContent imageName:nil anotherImage:@"right_arrow" viewController:self selector:nil anotherSelector:@selector(nextAction:) frame:CGRectZero anotherFrame:CGRectMake(0, 0, 20, 20)];
    
    
    
    UIButton *subMitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [subMitBtn setFrame:CGRectMake(10, discountView.bottom + 8.5, kScreenWidth - 20, 45)];
    subMitBtn.backgroundColor = [UIColor colorWithHexString:@"#e4504b"];
    [subMitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [subMitBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [subMitBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [subMitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:subMitBtn];
}

-(void)nextAction:(UIButton *)sender{

    NSLog(@"jsjjsjjjjj");
}

-(void)back:(UIBarButtonItem *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)pikerPhotos:(UIButton *)sender {
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:@[@"拍照",@"从手机相册选择"] distance:151];
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",(long)index, title];
        NSLog(@"%@",text);
    }];
}


- (void)submit:(UIButton *)sender {
    
    NSLog(@"提交");
}



@end
