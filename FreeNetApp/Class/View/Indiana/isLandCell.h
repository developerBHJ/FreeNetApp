//
//  isLandCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface isLandCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *themeImage;
@property (weak, nonatomic) IBOutlet arrowView *rightView;


@property (nonatomic,strong)PersonerGroup *model;



@end
