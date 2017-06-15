//
//  PersonerGroup.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerGroup.h"

@implementation PersonerGroup

-(instancetype)initWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle toViewController:(UIViewController *)viewController{

    self = [super init];
    if (self) {
        self.title = title;
        self.imageName = image;
        self.subTitle = subTitle;
        self.viewController = viewController;
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end



