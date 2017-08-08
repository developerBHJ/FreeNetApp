//
//  BHJNetWorkTools.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/28.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHJNetWorkTools : NSObject<NSCopying>

+ (instancetype _Nullable )sharedNetworkTool;

- (void)loadDataInfo:(nullable NSString *)URLString
          parameters:(nullable id)parameters
             success:(nullable void (^)(id _Nullable responseObject))success
             failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)loadDataInfoPost:(nullable NSString *)URLString
              parameters:(nullable id)parameters
                 success:(nullable void (^)(id _Nullable responseObject))success
                 failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)loadDataInfoDelete:(nullable NSString *)URLString
                parameters:(nullable id)parameters
                   success:(nullable void (^)(id _Nullable responseObject))success
                   failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)changeDataWithUrl:(nullable NSString *)url
               parameters:(nullable id)parameters
                  success:(nullable void (^)(id _Nullable responseObject))success
                  failure:(nullable void (^)(NSError * _Nullable error))failure;
@end
