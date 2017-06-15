//
//  EvaluationCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "EvaluationCell.h"

@implementation EvaluationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"nomal"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


    // Configure the view for the selected state
}

- (IBAction)myButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [sender setBackgroundImage:[UIImage imageNamed:@"selected_red"] forState:UIControlStateSelected];
}

-(void)upDataWithHead:(NSString *)headImage andTitle:(NSString *)title andIsselected:(BOOL)isSelect
{
    self.titleLabel.text = title;
    self.rightBtn.selected = isSelect;
}

-(void)updateWithSelectSatic
{
    NSLog(@"更新选中");
}


@end
