//
//  winningCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/27.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface winningCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UIImageView *user_head;
@property (weak, nonatomic) IBOutlet UIImageView *user_level;
@property (weak, nonatomic) IBOutlet UILabel *winningLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfrome;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseNumber;
@property (weak, nonatomic) IBOutlet UILabel *winningNum;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
