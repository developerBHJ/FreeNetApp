//
//  searchCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/2/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface searchCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightView;

@property (nonatomic,strong)SearchModel *model;

@property (nonatomic,strong)NSNumber *searchId;

@end
