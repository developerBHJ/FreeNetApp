//
//  PropertyHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/2.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

+(PropertyHeadView *)sharePropertyHeadView;

@end
