//
//  UIImage+Extension.h
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 圆角图片
- (UIImage *)clipImageWithRadius:(CGFloat)radius;


/**
 根据颜色和尺寸生成图片
 
 @param color 颜色
 @param size 输出图片大小
 @return 图片大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


@end
