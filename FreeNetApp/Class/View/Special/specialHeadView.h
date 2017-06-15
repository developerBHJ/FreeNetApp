//
//  specialHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/20.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJRatingBar.h"
@interface specialHeadView : UICollectionReusableView<BHJRatingBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet BHJRatingBar *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;


@end
