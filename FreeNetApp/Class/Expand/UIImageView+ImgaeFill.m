//
//  UIImageView+ImgaeFill.m
//  TeaAllusion
//
//  Created by 白华君 on 2017/3/8.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "UIImageView+ImgaeFill.h"

@implementation UIImageView (ImgaeFill)


-(void)imageFillImageView{

    [self setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.contentMode =  UIViewContentModeScaleAspectFit;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.clipsToBounds  = YES;
}



@end
