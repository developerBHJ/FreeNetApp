//
//  specialDetailCell_1.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/19.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJRatingBar.h"
@interface specialDetailCell_1 : BaseCollectionViewCell<BHJRatingBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *strveBtn;
@property (weak, nonatomic) IBOutlet UILabel *prePrice;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet BHJRatingBar *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@end
