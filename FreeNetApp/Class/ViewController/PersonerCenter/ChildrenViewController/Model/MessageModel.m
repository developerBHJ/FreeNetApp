//
//  MessageModel.m
//  FreeNetApp
//
//  Created by HanOBa on 2017/5/9.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.messageId = value;
    }
}



@end
