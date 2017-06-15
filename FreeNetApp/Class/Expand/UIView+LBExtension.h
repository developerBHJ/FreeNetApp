//
//  UIView+LBExtension.h
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (LBExtension)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;


/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

//弧线
-(void)drawArcFromCenter:(CGPoint)center
                  radius:(float)radius
              startAngle:(float)startAngle
                endAngle:(float)endAngle
               clockwise:(BOOL)clockwise;
//圆形
-(void)drawCircleWithCenter:(CGPoint)center
                     radius:(float)radius;

//矩形
-(void)drawRectangle:(CGRect)rect;

//直线
-(void)drawLineFrom:(CGPoint)startPoint
                 to:(CGPoint)endPoint;

//画多边形
//pointArray = @[[NSValue valueWithCGPoint:CGPointMake(200, 400)]];
-(void)drawPolygon:(NSArray *)pointArray;

//
//- (void)fadeIn;
//- (void)fadeOut;
//- (void)fadeInOnComplet:(void(^)(BOOL f))complet;
//- (void)fadeOutOnComplet:(void(^)(BOOL f))complet;
//
//- (void)removeAllSubviews;
//- (void)removeSubviewWithTag:(NSInteger)tag;
//- (void)removeSubviewExceptTag:(NSInteger)tag;
//- (void)removeSubviewExceptClass:(Class)class1;
//
//- (UIImage *)toAlphaRetinaImageRealTime;
//- (UIImage *)toRetinaImage;
//- (UIImage *)toAlphaRetinaImage;
//- (UIImage *)toImage;
//- (UIImage *)toImagewhithAlpha:(BOOL)alpha;
//- (UIImage *)toImageWithRect:(CGRect)frame;
//- (UIImage *)toImageWithRect:(CGRect)frame withAlpha:(BOOL)alpha;
//- (UIImage *)visbleToImage;
//
//- (void)addWhiteView;
//- (void)addWhiteViewWithAlpha:(float)alpha;
//- (void)addBlackView;
//- (void)addShadowWithColor:(UIColor *)color;
//- (void)addShadow;
//- (void)addShadowWithAlpha:(float)alpha;
//- (void)removeShadow;
//- (UIView *)findAndResignFirstResponder;
//- (void)addBorder;
//- (UIView *)addLine:(UIColor *)color frame:(CGRect)frame;
//
//- (void)addCorner;
//- (void)shake:(float)range;
//- (void)shakeRepeat:(float)range;
//- (void)shakeX:(float)range;
//- (void)rasterize;
//
//+ (void)vveboAnimations:(void (^)(void))animations;
//+ (void)vveboAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
//
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
//
//- (void)addLine:(CGRect)rect;
//- (BOOL)hasActionSheetOrAlert;
//- (UIView *)subviewWithTag:(NSInteger)tag;


-(CGMutablePathRef)pathwithFrame:(CGRect)frame withRadius:(float)radius;






@end
