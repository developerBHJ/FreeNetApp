//
//  specialDetailCell_5.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/20.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJRatingBar.h"

@interface specialDetailCell_5 : UICollectionViewCell

@property (nonatomic, strong) BaseModel *model;

@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *photosView;
@property (weak, nonatomic) IBOutlet BHJRatingBar *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



@end
