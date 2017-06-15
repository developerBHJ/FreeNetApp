//
//  PersonerViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoginStyle) {
    
    LoginFailure = 0,// 登陆失败
    LoginSucceed = 1,// 登陆成功
};

@interface PersonerViewController : UIViewController

@property (nonatomic,assign)LoginStyle loginStyle;

@end
