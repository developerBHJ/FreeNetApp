//
//  PersonerCell_0.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerCell_0.h"
@implementation PersonerCell_0

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // NSLog(@"%@",user_nickname);
    self.user_headImage.cornerRadius = 35;
    self.backgroundColor = HWColor(65, 105, 225, 0.7);
    if (user_login) {
        self.user_name.text = user_nickname;
        [self.user_headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:user_avatar_url] forState:(UIControlStateNormal)];
    }else{
        self.user_name.text = @"点击头像登陆";
        [self.user_headImage setBackgroundImage:[[[UIImage imageNamed:@"signOut"] clipImageWithRadius:self.user_headImage.width] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess:) name:@"singOut" object:nil];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)loginSuccess:(NSNotification *)info{
    
    int isSuccess = [info.userInfo[@"isSuccess"] intValue];
    if (isSuccess == 0) {
        self.user_name.text = user_nickname;
        [self.user_headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:user_avatar_url] forState:(UIControlStateNormal)];
    }else{
        self.user_name.text = @"点击头像登陆";
        [self.user_headImage setBackgroundImage:[[[UIImage imageNamed:@"signOut"] clipImageWithRadius:self.user_headImage.width] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (IBAction)levBtnAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

- (IBAction)editAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

- (IBAction)headImageAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

@end
