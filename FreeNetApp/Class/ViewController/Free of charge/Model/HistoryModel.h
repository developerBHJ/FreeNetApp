//
//  HistoryModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/27.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject

@property (nonatomic,strong)NSDictionary *user;
@property (nonatomic,strong)NSDictionary *user_level;
@property (nonatomic,assign)int id;
@property (nonatomic,assign)int coin;//立免钱币
@property (nonatomic,assign)BOOL status;

/*
 {
 "status": 200,
 "message": "获取数据成功",
 "data": [
 {
 "id": 1,
 "coin": 100,
 "status": true,
 "created_at": null,
 "user": {
 "id": 1,
 "avatar_url": "http://icareu365.oss-cn-beijing.aliyuncs.com/avatars/a893028c8b2398318982df3573265a94.jpeg",
 "nickname": "haahha",
 "winning": "0",
 "region": {
 "title": "西安市"
 },
 "user_level": {
 "id": 1,
 "level": {
 "cover_url": "www.baidu.com"
 }
 }
 }
 }
 ]
 }
 
 
 */
@end
