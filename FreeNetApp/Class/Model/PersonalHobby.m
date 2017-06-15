//
//  PersonalHobby.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/1.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonalHobby.h"

@implementation PersonalHobby


-(id)initWithTheme:(NSString *)theme color:(UIColor *)color{

    self = [super init];
    if (self) {
        self.themeTitle = theme;
        self.themeColor = color;
    }
    return self;
}


+(NSMutableDictionary *)setTagData{

    NSMutableDictionary *tagDic = [NSMutableDictionary new];
    PersonalHobby *model = [[PersonalHobby alloc]initWithTheme:@"美食" color:[UIColor colorWithHexString:@"#fcb38a"]];
    PersonalHobby *model_1 = [[PersonalHobby alloc]initWithTheme:@"旅游" color:[UIColor colorWithHexString:@"#39c3d3"]];
    PersonalHobby *model_2 = [[PersonalHobby alloc]initWithTheme:@"电影" color:[UIColor colorWithHexString:@"#66236e"]];
    PersonalHobby *model_3 = [[PersonalHobby alloc]initWithTheme:@"K歌" color:[UIColor colorWithHexString:@"#b62dbb"]];
    PersonalHobby *model_4 = [[PersonalHobby alloc]initWithTheme:@"温泉" color:[UIColor colorWithHexString:@"#6272c7"]];
    PersonalHobby *model_5 = [[PersonalHobby alloc]initWithTheme:@"美容spa" color:[UIColor colorWithHexString:@"#fcb38a"]];
    PersonalHobby *model_6 = [[PersonalHobby alloc]initWithTheme:@"摄影" color:[UIColor colorWithHexString:@"#c5394d"]];
    PersonalHobby *model_7 = [[PersonalHobby alloc]initWithTheme:@"运动健身" color:[UIColor colorWithHexString:@"#ffffff"]];
    PersonalHobby *model_8 = [[PersonalHobby alloc]initWithTheme:@"商品" color:[UIColor colorWithHexString:@"#d5b41a"]];
    NSArray *hobbyArr = [NSArray arrayWithObjects:model,model_1,model_2,model_3,model_4,model_5,model_6,model_7,model_8, nil];
    for (int i = 0; i < hobbyArr.count; i++) {
        PersonalHobby *model = hobbyArr[i];
        if (i == 7) {
            model.backColor = [UIColor colorWithHexString:@"#e66053"];
        }else{
            model.backColor = [UIColor whiteColor];
        }
    }
    [tagDic setObject:hobbyArr forKey:@"Hobby"];
    
    PersonalHobby *model_9= [[PersonalHobby alloc]initWithTheme:@"国企" color:[UIColor colorWithHexString:@"#fcb38a"]];
    PersonalHobby *model_10 = [[PersonalHobby alloc]initWithTheme:@"金融" color:[UIColor colorWithHexString:@"#39c3d3"]];
    PersonalHobby *model_11 = [[PersonalHobby alloc]initWithTheme:@"IT" color:[UIColor colorWithHexString:@"#66236e"]];
    PersonalHobby *model_12 = [[PersonalHobby alloc]initWithTheme:@"大学生" color:[UIColor colorWithHexString:@"#b62dbb"]];
    PersonalHobby *model_13 = [[PersonalHobby alloc]initWithTheme:@"其他学生" color:[UIColor colorWithHexString:@"#6272c7"]];
    PersonalHobby *model_14 = [[PersonalHobby alloc]initWithTheme:@"媒体" color:[UIColor colorWithHexString:@"#fcb38a"]];
    PersonalHobby *model_15 = [[PersonalHobby alloc]initWithTheme:@"餐饮" color:[UIColor colorWithHexString:@"#c5394d"]];
    PersonalHobby *model_16 = [[PersonalHobby alloc]initWithTheme:@"零售" color:[UIColor colorWithHexString:@"#ffffff"]];
    PersonalHobby *model_17 = [[PersonalHobby alloc]initWithTheme:@"自由职业" color:[UIColor colorWithHexString:@"#d5b41a"]];
    PersonalHobby *model_18 = [[PersonalHobby alloc]initWithTheme:@"教育" color:[UIColor colorWithHexString:@"#39c3d3"]];
    PersonalHobby *model_19 = [[PersonalHobby alloc]initWithTheme:@"医院" color:[UIColor colorWithHexString:@"#c5394d"]];
    PersonalHobby *model_20 = [[PersonalHobby alloc]initWithTheme:@"汽车" color:[UIColor colorWithHexString:@"#d5b41a"]];
    NSArray *occupationArr = [NSArray arrayWithObjects:model_9,model_10,model_11,model_12,model_13,model_14,model_15,model_16,model_17,model_18,model_19,model_20,nil];
    for (int i = 0; i < occupationArr.count; i++) {
        PersonalHobby *model = occupationArr[i];
        if (i == 7) {
            model.backColor = [UIColor colorWithHexString:@"#e66053"];
        }else{
            model.backColor = [UIColor whiteColor];
        }
    }
    [tagDic setObject:occupationArr forKey:@"Occupation"];
    
    PersonalHobby *model_21 = [[PersonalHobby alloc]initWithTheme:@"单身" color:[UIColor colorWithHexString:@"#ffffff"]];
    PersonalHobby *model_22 = [[PersonalHobby alloc]initWithTheme:@"热恋" color:[UIColor colorWithHexString:@"#ffal0d"]];
    PersonalHobby *model_23 = [[PersonalHobby alloc]initWithTheme:@"结婚" color:[UIColor colorWithHexString:@"#ce0f40"]];
    PersonalHobby *model_24 = [[PersonalHobby alloc]initWithTheme:@"有宝宝" color:[UIColor colorWithHexString:@"#f3518e"]];
    NSArray *lifeArr = [NSArray arrayWithObjects:model_21,model_22,model_23,model_24, nil];
    for (int i = 0; i < lifeArr.count; i++) {
        PersonalHobby *model = lifeArr[i];
        if (i == 0) {
            model.backColor = [UIColor colorWithHexString:@"#e66053"];
        }else{
            model.backColor = [UIColor whiteColor];
        }
    }
    [tagDic setObject:lifeArr forKey:@"Lifestyle"];
    
    return tagDic;
}

@end
