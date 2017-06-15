//
//  homeCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/23.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;


@end
