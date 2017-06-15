//
//  discountModel.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "discountModel.h"

static CGFloat const margin = 5.f;
static CGFloat const contentFont = 12.f;
static CGFloat const contentLabelY = margin + margin + 135;

@implementation discountModel{
    
    CGFloat _cellHeight;
}


- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 2 * margin; // 屏幕宽度减去左右间距
        CGFloat contentH = [self.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentFont]}
                                                      context:nil].size.height;
        _cellHeight = contentLabelY + contentH + margin;
        CGFloat imageH = 0;
        if (self.imageAr.count > 0) {
            for (NSString *str in self.imageAr) {
                //                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
                UIImage *image = [UIImage imageNamed:str];
                imageH = image.size.height;
            }
            if (self.imageAr.count > 2) {
                self.contentImageFrame = CGRectMake(10, _cellHeight, contentW,imageH * 2);
                _cellHeight += imageH * 2 + margin * 2 + 35;
            }else if (self.imageAr.count > 5){
                self.contentImageFrame = CGRectMake(10, _cellHeight, contentW,imageH * 3);
                _cellHeight += imageH * 3 + margin * 3;
            }else if(self.imageAr.count > 0 && self.imageAr.count < 3){
                self.contentImageFrame = CGRectMake(10, _cellHeight, contentW,imageH);
                _cellHeight += imageH + margin + 35;
            }
        }
    }
    return _cellHeight += 25;
}





@end
