//
//  BaseModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *phoneNumber;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *headImage;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *zip;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subTitle;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *imageName;
// 图片将要展示的frame
@property (nonatomic, assign) CGRect contentImageFrame;
@property (nonatomic,strong)NSArray *imageAr;
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end

