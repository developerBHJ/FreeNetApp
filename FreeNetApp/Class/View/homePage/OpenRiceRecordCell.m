//
//  OpenRiceRecordCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/5.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "OpenRiceRecordCell.h"

@implementation OpenRiceRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.userName setFont:[UIFont systemFontOfSize:12]];
    self.userName.textColor = [UIColor colorWithHexString:@"#000000"];
    [self.comefrom setFont:[UIFont systemFontOfSize:12]];
    self.comefrom.textColor = [UIColor colorWithHexString:@"#bebebe"];
    self.address.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.address setFont:[UIFont systemFontOfSize:12]];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
