//
//  UIButton+BHJButtonCategory.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "UIButton+BHJButtonCategory.h"
#import <objc/runtime.h>
@interface UIButton ()

/**bool 类型 YES 不允许点击   NO 允许点击   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end


@implementation UIButton (BHJButtonCategory)

- (void)layoutButtonWithEdgeInsetsStyle:(BHJButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case BHJButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(labelHeight-space/2.0, 0, 5, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(5, -imageWith,-imageHeight-space/2.0, 0);
        }
            break;
        case BHJButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case BHJButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case BHJButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}
- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
//当我们按钮点击事件 sendAction 时  将会执行  mySendAction
- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.isIgnore) {
        //不需要被hook
        [self mySendAction:action to:target forEvent:event];
        return;
    }
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        self.timeInterval =self.timeInterval == 0 ?defaultInterval:self.timeInterval;
        if (self.isIgnoreEvent){
            return;
        }else if (self.timeInterval > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
    }
    //此处 methodA和methodB方法IMP互换了，实际上执行 sendAction；所以不会死循环
    self.isIgnoreEvent = YES;
    [self mySendAction:action to:target forEvent:event];
}
//runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsIgnore:(BOOL)isIgnore{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnore{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)resetState{
    [self setIsIgnoreEvent:NO];
}



@end
