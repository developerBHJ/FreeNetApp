//
//  FlagStoreModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/26.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlagStoreModel : NSObject

@property (nonatomic,assign)int id;
@property (nonatomic,assign)int rate;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *lat; //纬度
@property (nonatomic,strong)NSString *lng;   //经度
@property (nonatomic,strong)NSString *tel;   //电话号码
@property (nonatomic,strong)NSString *open_time;   //营业时间
@property (nonatomic,strong)NSArray *shop_images;
@property (nonatomic,strong)NSString *logo_url;//店铺封面


/*
 {
 "id": 1,
 "title": "titlele",
 "rate": 1231,
 "address": "这个是路径",
 "open_time": "",
 "tel": "553434232",
 "lat": "34.265731",
 "lng": "108.953636",
 "shop_images": [
 {
 "id": 1,
 "image_url": "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2580913290,717743760&fm=26&gp=0.jpg"
 }
 ]
 }
 
 */
@end
