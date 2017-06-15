//
//  indianaDetailHeaderView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/22.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "indianaDetailHeaderView.h"

@implementation indianaDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];

    CGRect frame = self.frame;
    frame.size.width = MainScreen_width;
    frame.size.height = MainScreen_height;
    [self setFrame:frame];
    
    self.sliderView = [[TTRangeSlider alloc]initWithFrame:CGRectMake(0, 15, MainScreen_width - 30, self.slider.height - 15)];
    self.sliderView.delegate = self;
    self.sliderView.minValue = 0;
    self.sliderView.maxValue = 100;
    self.sliderView.handleColor = [UIColor whiteColor];
    self.sliderView.handleDiameter = 30;
    self.sliderView.selectedMaximum = 90;
    self.sliderView.selectedHandleDiameterMultiplier = 1.1;
    self.sliderView.lineHeight = 10;
    self.sliderView.tintColorBetweenHandles = [UIColor colorWithHexString:@"#bebebe"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveSuffix = @"元";
    self.sliderView.minLabelColour = [UIColor colorWithHexString:@"#e4504b"];
    self.sliderView.maxLabelColour = [UIColor greenColor];
    self.sliderView.numberFormatterOverride = formatter;
    self.sliderView.handleBorderWidth = 1;
    self.sliderView.handleBorderColor = [UIColor colorWithHexString:@"#cdcdcd"];
    self.sliderView.tintColor = [UIColor colorWithHexString:@"#e4504b"];
    [self.slider addSubview:self.sliderView];

    CGFloat origX = self.sliderView.selectedMinimum / 100 * self.slider.width;
    self.markView.transform = CGAffineTransformMakeRotation(M_PI);
    self.markView.fillColor = [UIColor colorWithHexString:@"#e4504b"];
    self.markView.strokeColor = [UIColor colorWithHexString:@"#e4504b"];
    self.leftSpace.constant = origX;
    self.cornerRadius = 5;
}


+(indianaDetailHeaderView *)shareIndianaDetailHeaderView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"indianaDetailHeaderView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

-(void)setModel:(IndianaDetailModel *)model{

    _model = model;
    self.sliderView.selectedMinimum = [model.snatch_price intValue];
    self.indianaPrice.text = model.snatch_price;
    self.currentPrice.text = model.snatch_price;
}
#pragma mark TTRangeSliderViewDelegate
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    
    NSLog(@"Currency slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
    CGRect frame = self.markView.frame;
    frame.origin.x = selectedMinimum / 100 * self.slider.width;
    [self.markView setFrame:frame];
}

@end
