//
//  BaseCollectionViewCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell


-(void)setCellWithModel:(BaseModel *)model{


}

@end

@implementation CollectionViewBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = [UIColor colorWithHexString:@"#8a8a8a"].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    border.frame = self.bounds;
    
    border.lineWidth = 1.f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @4];

    [self.layer addSublayer:border];
}
@end
