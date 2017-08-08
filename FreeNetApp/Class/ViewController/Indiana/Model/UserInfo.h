//
//  UserInfo.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/1.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic,strong)NSNumber *id;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *avatar_url;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,assign)BOOL sex;
@property (nonatomic,strong)NSString *age;
@property (nonatomic,assign)CGFloat gold;
@property (nonatomic,assign)CGFloat coin;
@property (nonatomic,strong)NSDictionary *user_level;

/*
 {
 "id": 1,
 "mobile": "13032980327",
 "avatar_url": "1",
 "nickname": "11212",
 "sex": true,
 "age": "2017-07-30T18:29:35.000Z",
 "gold": 90,
 "coin": 50,
 "user_level": {
 "id": 1,
 "is_buy": "",
 "expired_at": null,
 "level": {
 "id": 1,
 "cover_url": "http://pic36.nipic.com/20131207/4499633_224151069363_2.jpg",
 "title": "zzz",
 "exp_min": 0,
 "exp_max": 0,
 "exp_signed": 0,
 "coin_signed": 0,
 "free_times": 0,
 "eat_times": 0,
 "lucky_times": 0,
 "price": "0.00"
 }
 }
 
 
 
 
 */
@end
