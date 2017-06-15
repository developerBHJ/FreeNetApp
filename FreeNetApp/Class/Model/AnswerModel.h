//
//  AnswerModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
// 图片将要展示的frame
@property (nonatomic, assign) CGRect contentImageFrame;

@property (nonatomic,strong)NSString *rightViewName;
@property (nonatomic,strong)UIColor *titleColor;
@property (nonatomic,strong)UIColor *backColor;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
