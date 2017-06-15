//
//  BaseModel.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BaseModel.h"

static CGFloat const margin = 5.f;
static CGFloat const contentFont = 12.f;
static CGFloat const contentLabelY = margin + margin + 30;

@implementation BaseModel{
    CGFloat _cellHeight;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    NSLog(@"键值不匹配：%@",key);
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
        if (self.imageAr.count > 0) {
            _contentImageFrame = CGRectMake(10, _cellHeight, contentW,imageH);
            _cellHeight += imageH;
        }
    }
    return _cellHeight + 15;
}

@end
