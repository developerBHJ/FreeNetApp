//
//  MessageModel.h
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,strong)NSNumber *messageId;

@property (nonatomic,strong)NSString *message;

@property (nonatomic,strong)NSString *sendtime;

@property (nonatomic,strong)NSString *images;

@end
