//
//  MessageModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,strong)NSNumber *messageId;    //ID

@property (nonatomic,strong)NSString *msg;      //消息

@property (nonatomic,strong)NSString *created_at;   //时间

@end
