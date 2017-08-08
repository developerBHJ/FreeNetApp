//
//  FlagshipStoreHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/31.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "FlagshipStoreHeadView.h"

@implementation FlagshipStoreHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cornerRadius = 5;
        
        self.storeName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.width - 120, self.height - 10)];
        self.storeName.textColor = [UIColor colorWithHexString:@"#696969"];
        [self.storeName setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.storeName];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.rightBtn setFrame:CGRectMake(self.width - 110, 7, 100, self.height - 14)];
        self.rightBtn.borderColor = [UIColor colorWithHexString:@"#E6736F"];
        self.rightBtn.borderWidth = 2.0f;
        [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:@"#E6736F"] forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"官方旗舰店" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(enterFlagshipStore:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
    }
    return self;
}

-(void)enterFlagshipStore:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJCustomViewMethodWithButton:)]) {
        [self.delegate BHJCustomViewMethodWithButton:sender];
    }
}
@end
