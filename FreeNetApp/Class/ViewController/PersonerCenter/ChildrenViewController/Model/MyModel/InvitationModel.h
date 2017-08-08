//
//  InvitationModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/6/19.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitationModel : GoodsModel

@property (nonatomic,strong)NSString *avatar_url;   //头像
@property (nonatomic,strong)NSString *nickname; //昵称
@property (nonatomic,strong)NSNumber *coin; //欢乐豆
@property (nonatomic,strong)NSDictionary *region;   //地点字典
@property (nonatomic,strong)NSDictionary *invite;


@end
