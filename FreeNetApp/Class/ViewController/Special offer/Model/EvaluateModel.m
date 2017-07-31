//
//  EvaluateModel.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/29.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "EvaluateModel.h"

static CGFloat const margin = 5.f;
static CGFloat const contentFont = 12.f;
static CGFloat const contentLabelY = margin + margin + 30;

@implementation EvaluateModel{
    CGFloat _cellHeight;
}


- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 20; // 屏幕宽度减去左右间距
        CGFloat contentH = [self.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentFont]}
                                                      context:nil].size.height;
        _cellHeight = contentLabelY + contentH + margin;
        CGFloat imageH = contentW / 6;
        if (self.user_order_comment_images.count > 0) {
            _contentImageFrame = CGRectMake(10, _cellHeight, contentW,imageH);
            _cellHeight += imageH;
        }
    }
    return _cellHeight + 15;
}

@end
