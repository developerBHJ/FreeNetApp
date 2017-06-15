//
//  couponModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface couponModel : NSObject


@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSArray *markData;

@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign) CGRect contentImageFrame;



@end
