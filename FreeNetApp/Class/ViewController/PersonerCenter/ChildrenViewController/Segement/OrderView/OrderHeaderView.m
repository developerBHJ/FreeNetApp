//
//  OrderHeaderView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OrderHeaderView.h"

@implementation OrderHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithSubViews];
    }
    return self;
}

-(void)initWithSubViews{
    
    self.backgroundColor = [UIColor whiteColor];
    self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    [self.iconImage imageFillImageView];
    [self addSubview:self.iconImage];
    self.storeName = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, MainScreen_width - 50, 30)];
    self.storeName.textColor = [UIColor blackColor];
    [self.storeName setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:self.storeName];
}







@end
