//
//  CustomAnnotationView.m
//  Unicorn
//
//  Created by zhupeng on 16/5/6.
//  Copyright © 2016年 bhj_jun. All rights reserved.
//

#import "CustomAnnotationView.h"
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end
@implementation CustomAnnotationView

//如果大头针被选中时
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.image = [UIImage imageNamed:@"lvshi"];
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
        if (self.delegate  &&  [self.delegate respondsToSelector:@selector(findRoudWintAdress:)]) {
            
              [self.delegate findRoudWintAdress:self.calloutView.subtitle];
        
        }
        
      
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}






@end
