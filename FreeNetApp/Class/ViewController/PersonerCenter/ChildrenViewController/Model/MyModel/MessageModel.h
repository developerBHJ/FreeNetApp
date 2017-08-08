//
//  MessageModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : GoodsModel

@property (nonatomic,strong)NSString *msg;      //消息
@property (nonatomic,strong)NSNumber *type;
@property (nonatomic,assign)BOOL enabled;//0为未读1为已读



@end
