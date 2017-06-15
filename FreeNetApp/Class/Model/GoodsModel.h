//
//  GoodsModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/5/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic,assign)int id;
@property (nonatomic,assign)int gid;
@property (nonatomic,assign)int num;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *name;


/*
 id                    特价列表
 gid                  商品ID
 img                 商品图片
 name              商品名称
 original_price  商品原价
 price                商品现价
 num                 出售数量
 title                   商品描述
 
 */
@end
