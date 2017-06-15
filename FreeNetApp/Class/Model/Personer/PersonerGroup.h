//
//  PersonerGroup.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonerGroup : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *imageName;
@property (nonatomic,strong)NSString *subTitle;
@property (nonatomic,strong)UIViewController *viewController;
@property (nonatomic,strong)NSString *content;

@property (nonatomic,assign)BOOL isSelected;

-(instancetype)initWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle toViewController:(UIViewController *)viewController;


@end

