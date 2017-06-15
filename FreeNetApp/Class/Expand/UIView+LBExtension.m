//
//  UIView+LBExtension.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "UIView+LBExtension.h"

#define PI 3.1415926

@implementation UIView (LBExtension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = CGRectStandardize(frame);
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = CGRectStandardize(frame);
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = CGRectStandardize(frame);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = CGRectStandardize(frame);
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame= frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)alignHorizontal
{
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical
{
    self.y = (self.superview.height - self.height) *0.5;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (BOOL)isShowOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)borderWidth
{
    return self.borderWidth;
}

- (UIColor *)borderColor
{
    return self.borderColor;

}

- (CGFloat)cornerRadius
{
    return self.cornerRadius;
}

- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}



/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

//矩形
-(void)drawRectangle:(CGRect)rect
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef pathRef = [self pathwithFrame:rect withRadius:0];
    
    CGContextAddPath(context, pathRef);
    CGContextDrawPath(context,kCGPathFillStroke);
    
    CGPathRelease(pathRef);
}


//直线
-(void)drawLineFrom:(CGPoint)startPoint
                 to:(CGPoint)endPoint
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x,endPoint.y);
    
    CGContextStrokePath(context);
}

//弧线
-(void)drawArcFromCenter:(CGPoint)center
                  radius:(float)radius
              startAngle:(float)startAngle
                endAngle:(float)endAngle
               clockwise:(BOOL)clockwise
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context,
                    center.x,
                    center.y,
                    radius,
                    startAngle,
                    endAngle,
                    clockwise?0:1);
    
    CGContextStrokePath(context);
}


//多边形
-(void)drawPolygon:(NSArray *)pointArray
{
    NSAssert(pointArray.count>=2,@"数组长度必须大于等于2");
    NSAssert([[pointArray[0] class] isSubclassOfClass:[NSValue class]], @"数组成员必须是CGPoint组成的NSValue");
    
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    NSValue *startPointValue = pointArray[0];
    CGPoint  startPoint      = [startPointValue CGPointValue];
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    
    for(int i = 1;i<pointArray.count;i++)
    {
        NSAssert([[pointArray[i] class] isSubclassOfClass:[NSValue class]], @"数组成员必须是CGPoint组成的NSValue");
        NSValue *pointValue = pointArray[i];
        CGPoint  point      = [pointValue CGPointValue];
        CGContextAddLineToPoint(context, point.x,point.y);
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

//圆形
-(void)drawCircleWithCenter:(CGPoint)center
                     radius:(float)radius
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGPathAddArc(pathRef,
                 &CGAffineTransformIdentity,
                 center.x,
                 center.y,
                 radius,
                 -PI/2,
                 radius*2*PI-PI/2,
                 NO);
    CGPathCloseSubpath(pathRef);
    
    CGContextAddPath(context, pathRef);
    CGContextDrawPath(context,kCGPathFillStroke);
    
    CGPathRelease(pathRef);
    
}
//- (void)fadeIn{
//    [self fadeInOnComplet:nil];
//}
//
//- (void)fadeOut{
//    [self fadeOutOnComplet:nil];
//}
//
//- (void)fadeInOnComplet:(void(^)(BOOL finished))complet{
//    self.alpha = 0;
//    [UIView animateWithDuration:.18 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//		self.alpha = 1;
//	} completion:complet];
//}
//
//- (void)fadeOutOnComplet:(void(^)(BOOL finished))complet{
//    [UIView animateWithDuration:.18 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        self.alpha = 0;
//    } completion:complet];
//	if ([UIView areAnimationsEnabled]) {
//		[UIView setAnimationsEnabled:YES];
//	}
//}
//
//- (void)removeAllSubviews{
//    for (UIView *temp in self.subviews) {
//        [temp removeFromSuperview];
//    }
//}
//
//- (void)removeSubviewWithTag:(NSInteger)tag{
//    for (UIView *temp in self.subviews) {
//        if (temp.tag==tag) {
//            [temp removeFromSuperview];
//        }
//    }
//}
//
//- (void)removeSubviewExceptTag:(NSInteger)tag{
//    for (UIView *temp in self.subviews) {
//        if (temp.tag!=tag) {
//			if ([temp isKindOfClass:[UIImageView class]]) {
//				[(UIImageView *)temp setImage:nil];
//			}
//            [temp removeFromSuperview];
//        }
//    }
//}
//
//- (void)removeSubviewExceptClass:(Class)class{
//    for (UIView *temp in self.subviews) {
//        if (![temp isKindOfClass:class]) {
//            [temp removeFromSuperview];
//        }
//    }
//}
//
//- (UIView *)addLine:(UIColor *)color frame:(CGRect)frame{
//    UIView *line = [[UIView alloc] initWithFrame:frame];
//    line.backgroundColor = color;
//    [self addSubview:line];
//    return line;
//}
//
//- (UIImage *)toImage{
//    return [self toImagewhithAlpha:NO];
//}
//
//- (UIImage *)toRetinaImageRealTime{
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return screenShotimage;
//}
//
//- (UIImage *)toRetinaImage{
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
//	[self drawViewHierarchyInRect:self.bounds
//               afterScreenUpdates:NO];
//    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return screenShotimage;
//}
//
//- (UIImage *)toAlphaRetinaImageRealTime{
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return screenShotimage;
//}
//
//- (UIImage *)toAlphaRetinaImage{
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
//	[self drawViewHierarchyInRect:self.bounds
//               afterScreenUpdates:NO];
//    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return screenShotimage;
//}
//
//- (UIImage *)toImagewhithAlpha:(BOOL)alpha{
//	NSInteger scale = ([UIDevice isiPhone4]||[UIDevice isiPad])?5:2.5;
//    CGSize size = CGSizeMake((NSInteger)(self.width/scale), (NSInteger)self.height/scale);
//	UIGraphicsBeginImageContextWithOptions(size, !alpha, 1);
//	[self drawViewHierarchyInRect:CGRectMake(0, 0, size.width, size.height)
//               afterScreenUpdates:NO];
//	UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//    return [screenShotimage normalize];
//}
//
//- (UIImage *)toImageWithRect:(CGRect)frame{
//    return [self toImageWithRect:frame withAlpha:NO];
//}
//
//- (void)addBorder{
//	UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, .5)];
//	line.backgroundColor = [VVeboConfigCenter defaultCenter].color_RepostBorder;
//	[self addSubview:line];
//
//	UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-.5, self.width, .5)];
//	line2.backgroundColor = [VVeboConfigCenter defaultCenter].color_RepostBorder;
//	[self addSubview:line2];
//
//	UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, .5, self.height)];
//	line3.backgroundColor = [VVeboConfigCenter defaultCenter].color_RepostBorder;
//	[self addSubview:line3];
//
//	UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(self.width-.5, 0, .5, self.height)];
//	line4.backgroundColor = [VVeboConfigCenter defaultCenter].color_RepostBorder;
//	[self addSubview:line4];
//}
//
//- (UIImage *)toImageWithRect:(CGRect)frame withAlpha:(BOOL)alpha{
//    UIGraphicsBeginImageContextWithOptions(frame.size, !alpha, 1);//这里通过设置scale为1来截取{[UIScreen screenWidth], 49}大小的图,而不是在retina下截取2x大小的图
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-frame.origin.x, -frame.origin.y));
//    [self.layer renderInContext:context];
//    UIImage *screenShot1 = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return screenShot1;
//}
//
//- (UIImage *)visbleToImage{
//	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//	if ([self isKindOfClass:[UIScrollView class]]) {
//		CGPoint offset=[(UIScrollView *)self contentOffset];
//		CGContextTranslateCTM(context, -offset.x, -offset.y);
//	}
////	[self.layer renderInContext:context];
//	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
//	UIImage *visibleScrollViewImage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//	return visibleScrollViewImage;
//}
//
//- (void)addWhiteViewWithAlpha:(float)alpha{
//    UIView *white = [[UIView alloc] initWithFrame:CGRectChangeOrigin(self.frame, CGPointZero)];
//    white.backgroundColor = [UIColor whiteColor];
//    white.alpha = alpha;
//    [self addSubview:white];
//}
//
//- (void)addWhiteView{
//	[self addWhiteViewWithAlpha:.8];
//}
//
//- (void)addBlackView{
//    UIView *black = [[UIView alloc] initWithFrame:CGRectChangeOrigin(self.frame, CGPointZero)];
//    black.backgroundColor = [UIColor blackColor];
//    black.alpha = .85;
//    [self addSubview:black];
//}
//
//- (void)addShadowWithAlpha:(float)alpha{
//	UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height)];
//	[self.layer setShadowColor:[UIColor grayColor].CGColor];
//	[self.layer setShadowOpacity:alpha];
//	[self.layer setShadowRadius:10.0f];
//	[self.layer setShadowPath:[path CGPath]];
//}
//
//- (void)addShadow{
//	[self addShadowWithAlpha:1];
//}
//
//- (void)addShadowWithColor:(UIColor *)color{
//	UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height)];
//	[self.layer setShadowColor:color.CGColor];
//	[self.layer setShadowOpacity:1];
//	[self.layer setShadowRadius:10.0f];
//	[self.layer setShadowPath:[path CGPath]];
//}
//
//- (void)removeShadow{
//	self.layer.shadowOpacity = 0;
//	self.layer.shadowRadius = 0;
//}
//
//- (UIView *)findAndResignFirstResponder{
//    if (self.isFirstResponder) {
//        return self;
//    }
//    for (UIView *subView in self.subviews) {
//        UIView *temp = [subView findAndResignFirstResponder];
//        if (temp!=nil) {
//            return temp;
//        }
//    }
//    return nil;
//}
//
//- (void)addCorner{
//    UIImageView *cornder = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"corner.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)]];
//    cornder.contentMode = UIViewContentModeScaleAspectFit;
//    cornder.frame = CGRectMake(0, 0, self.width, self.height);
//    [self addSubview:cornder];
//}
//
//- (void)shake:(float)range{
//	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    animation.duration = 0.5;
//    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
//    [self.layer addAnimation:animation forKey:@"shake"];
//}
//
//- (void)shakeRepeat:(float)range{
//	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    animation.duration = 0.6;
//    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
//	animation.repeatCount = NSIntegerMax;
//    [self.layer addAnimation:animation forKey:@"shake"];
//}
//
//- (void)shakeX:(float)range{
//	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    animation.duration = 0.6;
//    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
//    [self.layer addAnimation:animation forKey:@"shake"];
//}
//
//- (void)rasterize{
//	self.layer.shouldRasterize = YES;
//	self.layer.rasterizationScale = [UIScreen scale];
//}
//
//+ (void)vveboAnimations:(void (^)(void))animations{
//	[UIView vveboAnimateWithDuration:.18 delay:0 animations:animations completion:nil];
//}
//
//+ (void)vveboAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
//	[UIView vveboAnimateWithDuration:.18 delay:0 animations:animations completion:completion];
//}
//
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations{
//	[UIView vveboAnimateWithDuration:duration delay:0 animations:animations completion:nil];
//}
//
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
//	[UIView vveboAnimateWithDuration:duration delay:0 animations:animations completion:completion];
//}
//
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
//	[UIView vveboAnimateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:animations completion:completion];
//}
//
//+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
//	if (![UIView areAnimationsEnabled]) {
//		[UIView setAnimationsEnabled:YES];
//	}
//	[UIView animateWithDuration:duration delay:delay options:options animations:animations completion:completion];
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//	if (self.touchBeganBlock) {
//		self.touchBeganBlock([touches anyObject], self);
//	}
//	[super touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//	if (self.touchEndBlock) {
//		self.touchEndBlock([touches anyObject], self);
//	}
//	[super touchesEnded:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//	if (self.touchMoveBlock) {
//		self.touchMoveBlock([touches anyObject], self);
//	}
//	[super touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//	if (self.touchEndBlock) {
//		self.touchEndBlock([touches anyObject], self);
//	}
//	[super touchesCancelled:touches withEvent:event];
//}
//
//- (void)addLine:(CGRect)rect{
//	UIColor *color = self.lineColor;
//	if (self.lineColor==nil) {
//		color = [UIColor grayColor];
//	}
//	UIView *line = [[UIView alloc] initWithFrame:rect];
//	line.backgroundColor = color;
//	[self addSubview:line];
//}
//
//- (BOOL)hasActionSheetOrAlert{
//    if ([self isKindOfClass:[UIAlertView class]]||[self isKindOfClass:[UIActionSheet class]]) {
//        return YES;
//    }
//    for (UIView *subView in self.subviews) {
//        BOOL temp = [subView hasActionSheetOrAlert];
//        if (temp) {
//            return temp;
//        }
//    }
//    return NO;
//}
//
//- (UIView *)subviewWithTag:(NSInteger)tag{
//    for (UIView *temp in self.subviews) {
//        if (temp.tag==tag) {
//            return temp;
//        }
//    }
//    return nil;
//}


-(CGMutablePathRef)pathwithFrame:(CGRect)frame withRadius:(float)radius
{
    CGPoint x1,x2,x3,x4; //x为4个顶点
    CGPoint y1,y2,y3,y4,y5,y6,y7,y8; //y为4个控制点
    //从左上角顶点开始，顺时针旋转,x1->y1->y2->x2
    
    x1 = frame.origin;
    x2 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y);
    x3 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height);
    x4 = CGPointMake(frame.origin.x                 , frame.origin.y+frame.size.height);
    
    
    y1 = CGPointMake(frame.origin.x+radius, frame.origin.y);
    y2 = CGPointMake(frame.origin.x+frame.size.width-radius, frame.origin.y);
    y3 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+radius);
    y4 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height-radius);
    
    y5 = CGPointMake(frame.origin.x+frame.size.width-radius, frame.origin.y+frame.size.height);
    y6 = CGPointMake(frame.origin.x+radius, frame.origin.y+frame.size.height);
    y7 = CGPointMake(frame.origin.x, frame.origin.y+frame.size.height-radius);
    y8 = CGPointMake(frame.origin.x, frame.origin.y+radius);
    
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    if (radius<=0) {
        CGPathMoveToPoint(pathRef,    &CGAffineTransformIdentity, x1.x,x1.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x2.x,x2.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x3.x,x3.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x4.x,x4.y);
    }else
    {
        CGPathMoveToPoint(pathRef,    &CGAffineTransformIdentity, y1.x,y1.y);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y2.x,y2.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x2.x,x2.y,y3.x,y3.y,radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y4.x,y4.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x3.x,x3.y,y5.x,y5.y,radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y6.x,y6.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x4.x,x4.y,y7.x,y7.y,radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y8.x,y8.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x1.x,x1.y,y1.x,y1.y,radius);
        
    }
    
    
    CGPathCloseSubpath(pathRef);
    
    //[[UIColor whiteColor] setFill];
    //[[UIColor blackColor] setStroke];
    
    return pathRef;
}

@end
