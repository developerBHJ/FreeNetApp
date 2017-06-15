//
//  BHJSegementHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)(NSInteger index);

@interface BHJSegementHeadView : UIView

/**
 *  未选中时的文字颜色,默认黑色
 */
@property (nonatomic,strong) UIColor *titleNomalColor;

/**
 *  选中时的文字颜色,默认红色
 */
@property (nonatomic,strong) UIColor *titleSelectColor;

/**
 *  字体大小，默认15
 */
@property (nonatomic,strong) UIFont  *titleFont;

/**
 *  默认选中的index=1，即第一个
 */
@property (nonatomic,assign) NSInteger defaultIndex;

@property (nonatomic,assign) CGFloat btn_w;
@property (nonatomic,strong) UILabel *separaterLine;

@property (nonatomic,assign)CGFloat separaterSpace;

@property (nonatomic,copy)btnClickBlock block;


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block;


@end
