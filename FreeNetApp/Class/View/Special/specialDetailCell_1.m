//
//  specialDetailCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "specialDetailCell_1.h"

@implementation specialDetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.ratingView setImageDeselected:@"star_half" halfSelected:nil fullSelected:@"star_red" andDelegate:self];
    NSString *str = [self.ratingLabel.text substringToIndex:1];
    [self.ratingView displayRating:[str floatValue]];
    self.ratingView.isIndicator = YES;
    [self.commentBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleRight imageTitleSpace:5];
}

-(void)ratingBar:(BHJRatingBar *)ratingBar ratingChanged:(float)newRating{

//    self.ratingLabel.text = [NSString stringWithFormat:@"%.f",newRating];
}

- (IBAction)commentAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}
- (IBAction)striveAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

@end
