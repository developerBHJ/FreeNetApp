//
//  cashCouponCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cashCouponCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *pre_Price;
@property (weak, nonatomic) IBOutlet UILabel *saleNum;
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *validityLabel;





@end
