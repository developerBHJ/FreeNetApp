//
//  indianaDetailWinningView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "indianaDetailWinningView.h"

@implementation indianaDetailWinningView

-(void)layoutSubViews{
    
    CGRect frame = self.frame;
    frame.size.width = MainScreen_width;
    frame.size.height = MainScreen_height;
    [self setFrame:frame];
}

+(indianaDetailWinningView *)shareIndianaDetailWinningView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"indianaDetailWinningView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.cornerRadius = 5;
    }
    return self;
}



-(void)setModel:(IndianaDetailModel *)model{
    
    _model = model;
    self.priceLabel.text = model.snatch_price;
}
@end
