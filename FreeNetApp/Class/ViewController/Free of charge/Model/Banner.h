//
//  Banner.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)int id;
@property (nonatomic,strong)NSString *url; //内容
@property (nonatomic,strong)NSString *image_url;// 图片

/*
 {
 "id": 1,
 "title": "这是免费轮播图1",
 "image_url": "http://oss.ktvgo.cn/avatars/default.png",
 "schema": "这个是啥协议",
 "url": "https://image.baidu.",
 "expired_at": "2017-08-10T00:00:00.000Z",
 "views": 0,
 "status": true,
 "channel": {
 "title": "免费"
 }
 },
 */
@end
