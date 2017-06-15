//
//  BerserkHistoryCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BerserkHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UILabel *circleLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel_down;
@property (weak, nonatomic) IBOutlet UILabel *markLabel_Up;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *comfrome;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *awardLabel;
@property (weak, nonatomic) IBOutlet UILabel *winningRate;
@property (weak, nonatomic) IBOutlet UIImageView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *user_level;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;

+(instancetype)initWithTableView:(UITableView *)tableview;




@end
