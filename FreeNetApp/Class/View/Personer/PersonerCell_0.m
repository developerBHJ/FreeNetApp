//
//  PersonerCell_0.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "PersonerCell_0.h"
@implementation PersonerCell_0

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.user_headImage.cornerRadius = 35;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)initWithTableView:(UITableView *)tableview
{
    PersonerCell_0 *cell=[tableview dequeueReusableCellWithIdentifier:@"PersonerCell_0"];
    if (cell == nil) {
        cell=[[PersonerCell_0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonerCell_0"];
        cell.backgroundColor = HWColor(65, 105, 225, 0.7);
    }
    return cell;
}

- (IBAction)levBtnAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

- (IBAction)editAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

- (IBAction)headImageAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:index:) ]) {
        [self.delegate MethodWithButton:sender index:self.index];
    }
}

@end
