//
//  couponModel.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "couponModel.h"

static CGFloat const margin = 8.f;

@implementation couponModel{
    CGFloat _cellHeight;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 2 * 10; // 屏幕宽度减去左右间距
        CGFloat contentH = MainScreen_height / 6.68;
        _cellHeight = contentH + margin;
        CGFloat imageH = 0;
        if (self.markData.count > 0) {
            imageH = MainScreen_height / 22.27;
        }
        _contentImageFrame = CGRectMake(0, _cellHeight, contentW,imageH);
        _cellHeight += imageH;
    }
    return _cellHeight;
}

@end
