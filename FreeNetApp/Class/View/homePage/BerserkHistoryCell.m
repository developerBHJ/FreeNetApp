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


-(void)setModel:(HistoryModel *)model{
    
    _model = model;
    [self.user_image sd_setImageWithURL:[NSURL URLWithString:model.user[@"avatar_url"]]];
    self.user_name.text = model.user[@"nickname"];
    [self.user_level sd_setImageWithURL:[NSURL URLWithString:model.user_level[@"level"][@"cover_url"]]];
    self.address.text = model.user[@"region"][@"title"];
    self.winningRate.text = model.user[@"winning"];
    self.numberLabel.text = [NSString stringWithFormat:@"%d",model.coin];
    if (model.status) {
        self.circleLabel.backgroundColor = [UIColor colorWithHexString:@"#e34a44"];
        self.leftView.image = [UIImage imageNamed:@"berserk_back_red"];
        self.user_name.textColor = [UIColor colorWithHexString:@"#e4504b"];
        self.markLabel.backgroundColor = [UIColor colorWithHexString:@"#e34a44"];
        self.user_image.borderColor = [UIColor colorWithHexString:@"#e34a44"];
        self.user_image.borderWidth = 2.5;
        self.firstLabel.hidden = YES;
    }else{
        self.circleLabel.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
        self.leftView.image = [UIImage imageNamed:@"BGView_gray"];
        self.user_name.textColor = [UIColor colorWithHexString:@"#696969"];
        self.markLabel.backgroundColor = [UIColor colorWithHexString:@"#bebebe"];
        self.firstLabel.hidden = NO;
    }
}

@end
