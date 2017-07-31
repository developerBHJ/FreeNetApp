//
//  EvaluateModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/29.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluateModel : GoodsModel

@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *created_at;
@property (nonatomic,strong)NSDictionary *user;
@property (nonatomic,strong)NSArray *user_order_comment_images;

@property (nonatomic, assign) CGRect contentImageFrame;
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/*
 
 "data": {
 "order_product": {
 "id": 1,
 "trade_no": "12313123"
 },
 "comments": [
 {
 "id": 5,
 "content": "这个是特价订单评论",
 "created_at": "2017-09-12T09:21:10.000Z",
 "user": {
 "id": 1,
 "nickname": "haahha"
 },
 "user_order_comment_images": [
 {
 "id": 1,
 "image_url": "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2580913290,717743760&fm=26&gp=0.jpg,https:"
 }
 ]
 },
 {
 "id": 9,
 "content": "这个是特价订单hahhaha",
 "created_at": "2017-09-12T09:21:10.000Z",
 "user": {
 "id": 2,
 "nickname": "xxuxuxux"
 },
 "user_order_comment_images": [
 {
 "id": 2,
 "image_url": "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2580913290,717743760&fm=26&gp=0.jpg"
 }
 ]
 }
 ]
 }
 
 */
@end
