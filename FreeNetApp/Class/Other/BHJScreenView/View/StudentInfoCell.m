//
//  StudentInfoCell.m
//  HeaderViewTapAnimation
//
//  Created by YouXianMing on 15/9/16.
//  Copyright (c) 2015年 ZiPeiYi. All rights reserved.
//

#import "StudentInfoCell.h"
#import "UIView+SetRect.h"
#import "screenModel.h"
@interface StudentInfoCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *rightView;

@end

@implementation StudentInfoCell

- (void)loadContent {

     self.nameLabel.text = self.data;
}

- (void)buildSubview {

    self.nameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 44)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.nameLabel];
    
    UIView *line2         = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width - 20, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
    [self addSubview:line2];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.rightView = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 50, 12, 20, 20)];
    self.rightView.image        = [UIImage imageNamed:@"selected_gray"];
    [self addSubview:self.rightView];
}

- (void)showSelectedAnimation {
    
    UIView *tmpView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    tmpView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.15f];
    tmpView.alpha           = 0.f;
    [self addSubview:tmpView];
    self.rightView.image = [UIImage imageNamed:@"selected_red"];

    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tmpView.alpha = 0.8f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.20 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            tmpView.alpha = 0.f;
        } completion:^(BOOL finished) {
            
            [tmpView removeFromSuperview];
        }];
    }];
}


@end
