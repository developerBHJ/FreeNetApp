//
//  VerificationViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZHBlock)(NSString *str);


@interface VerificationViewController : BHJViewController

@property (nonatomic,strong)NSString *iphoneNum;

@property (nonatomic,copy)ZHBlock block;

-(void)strWithBlock:(ZHBlock)block;

@end
