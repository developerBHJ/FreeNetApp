//
//  UIButton+BHJButtonCategory.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval .5  //默认时间间隔

typedef NS_ENUM(NSUInteger, BHJButtonEdgeInsetsStyle) {
    BHJButtonEdgeInsetsStyleTop, // image在上，label在下
    BHJButtonEdgeInsetsStyleLeft, // image在左，label在右
    BHJButtonEdgeInsetsStyleBottom, // image在下，label在上
    BHJButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (BHJButtonCategory)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(BHJButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**
 *  用于设置单个按钮不需要被hook
 */
@property (nonatomic, assign) BOOL isIgnore;






@end
