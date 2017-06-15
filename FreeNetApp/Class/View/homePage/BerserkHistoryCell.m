//
//  BerserkHistoryCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BerserkHistoryCell.h"

@implementation BerserkHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.user_image.cornerRadius = self.user_image.height / 2;
    self.circleLabel.cornerRadius = self.circleLabel.width / 2;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


+(instancetype)initWithTableView:(UITableView *)tableview
{
    BerserkHistoryCell *cell=[tableview dequeueReusableCellWithIdentifier:@"BerserkHistoryCell"];
    if (cell == nil) {
        cell=[[BerserkHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BerserkHistoryCell"];
    }
    return cell;
}


@end
