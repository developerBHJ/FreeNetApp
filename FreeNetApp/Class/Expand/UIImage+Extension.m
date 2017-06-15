//
//  UIImage+Extension.m
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)clipImageWithRadius:(CGFloat)radius{
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    
    if(radius<0){radius = 0;}
    if (radius>MIN(w, h)) {
        radius = MIN(w, h);
    }
    
    CGRect imgFrame = CGRectMake(0, 0, w, h);
    
    UIGraphicsBeginImageContextWithOptions(imgFrame.size, NO, 0);
    UIBezierPath  *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, w, h) cornerRadius:radius];
    [path addClip];
    [self drawInRect:imgFrame];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
 }


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
