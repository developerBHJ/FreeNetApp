//
//  moreClassHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"
@interface moreClassHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *themeImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)ClassModel *model;

@end
