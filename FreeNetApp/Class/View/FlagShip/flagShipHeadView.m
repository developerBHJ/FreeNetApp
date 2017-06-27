//
//  flagShipHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/23.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "flagShipHeadView.h"

@implementation flagShipHeadView

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.ratingView setImageDeselected:@"star_half" halfSelected:nil fullSelected:@"star_red" andDelegate:self];
    self.ratingView.isIndicator = YES;
    [self.followBtn setImage:[[UIImage imageNamed:@"add_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.followBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:5];


}



- (IBAction)followAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJReusableViewDelegateMethodWithIndexPath:button:)]) {
        [self.delegate BHJReusableViewDelegateMethodWithIndexPath:self.indexPath button:sender];
    }
}


-(void)ratingBar:(BHJRatingBar *)ratingBar ratingChanged:(float)newRating{


}

-(void)setModel:(FlagStoreModel *)model{

    _model = model;
    self.store_name.text = model.title;
    self.address.text = model.address;
    [self.ratingView displayRating:model.rate];
    self.timeLabel.text = model.open_time;
    [self.store_image sd_setImageWithURL:[NSURL URLWithString:model.logo_url]];
}



@end
