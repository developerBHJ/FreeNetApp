//
//  MyCollectionCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storeLogoImage;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeName;


@end
