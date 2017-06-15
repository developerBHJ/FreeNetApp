//
//  PersonalHobby.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/1.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalHobby : NSObject

@property (nonatomic,strong)NSString *themeTitle;
@property (nonatomic,strong)UIColor *themeColor;
@property (nonatomic,strong)UIColor *backColor;

-(id)initWithTheme:(NSString *)theme color:(UIColor *)color;

+(NSDictionary *)setTagData;

@end
