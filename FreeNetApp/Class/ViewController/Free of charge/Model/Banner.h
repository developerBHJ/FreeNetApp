//
//  Banner.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject

@property (nonatomic,strong)NSString *content;
@property (nonatomic,assign)int id;
@property (nonatomic,assign)int link;
@property (nonatomic,strong)NSString *name;
/*
 {
 content = "temp/ads/201612210455331571.jpg";
 id = 2;
 link = 1;
 name = "\U5e7f\U544a1";
 },
 
 id          广告ID
 name    广告名称
 link        广告链接
 content  图片地址
 */
@end
