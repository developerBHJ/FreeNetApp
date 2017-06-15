
#import "arrowView.h"
#define kArrowHeight 10
@implementation arrowView
- (void)drawRect:(CGRect)rect
{
    //设置背景颜色
    [[UIColor
      clearColor]set];
    UIRectFill([self bounds]);
    //拿到当前视图准备好的画板
    CGContextRef
    context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    
    CGContextBeginPath(context);//标记
    
    
    CGContextMoveToPoint(context,
                         0, 0);//设置起点

    CGContextAddLineToPoint(context,
                            self.width,0);
    CGContextAddLineToPoint(context,
                            self.width / 2, self.height / 2);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [self.fillColor setFill];
    //设置填充色
    [self.strokeColor setStroke];
    //设置边框颜色
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
    
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

@end
