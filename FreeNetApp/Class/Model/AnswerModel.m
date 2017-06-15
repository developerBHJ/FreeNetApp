//
//  AnswerModel.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AnswerModel.h"

static CGFloat const margin = 10.f;
static CGFloat const contentFont = 12.f;
static CGFloat const contentLabelY = margin + margin + 30;

@implementation AnswerModel{
    CGFloat _cellHeight;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    AnswerModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}


- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 2 * margin; // 屏幕宽度减去左右间距
        CGFloat contentH = [self.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentFont]}
                                                      context:nil].size.height;
        _cellHeight = contentLabelY + contentH + margin;
        if (self.imageName.length) {
            UIImage *image = [UIImage imageNamed:self.imageName];
            CGFloat imageH = image.size.height;
            CGFloat imageW = image.size.width;
            _contentImageFrame = CGRectMake((contentW - imageW - 40) / 2, _cellHeight, imageW + 40, imageH + 30);
            _cellHeight += imageH + margin;
        }
    }
    return _cellHeight;
}

@end