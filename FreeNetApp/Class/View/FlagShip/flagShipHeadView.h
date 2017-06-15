//
//  flagShipHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/23.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJRatingBar.h"
@interface flagShipHeadView : BHJReusableView<BHJRatingBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *store_image;
@property (weak, nonatomic) IBOutlet UILabel *store_name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet BHJRatingBar *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;





@end
