//
//  PersonerCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerCell.h"

@implementation PersonerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithModel:(PersonerGroup *)model{

    self.headImage.image = [[UIImage imageNamed:model.imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.headImage imageFillImageView];
    
    self.title.text = model.title;
    self.contentLabel.text = model.content;
    self.subTitle.text = model.subTitle;
    self.title.textColor = [UIColor colorWithHexString:@"#696969"];
    self.subTitle.textColor = [UIColor colorWithHexString:@"#e4504b"];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"#696969"];
}
@end
