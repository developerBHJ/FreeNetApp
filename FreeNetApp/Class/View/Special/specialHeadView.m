//
//  specialHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/20.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "specialHeadView.h"

@implementation specialHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.ratingView setImageDeselected:@"star_half" halfSelected:nil fullSelected:@"star_red" andDelegate:self];
    self.ratingView.isIndicator = YES;
    [self.ratingView displayRating:4];
}

-(void)ratingBar:(BHJRatingBar *)ratingBar ratingChanged:(float)newRating{
    
}
@end
