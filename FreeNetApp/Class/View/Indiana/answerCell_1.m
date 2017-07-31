//
//  answerCell_1.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "answerCell_1.h"

@implementation answerCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

}

-(void)setAnswer:(NSDictionary *)answer{
    
    _answer = answer;
    self.contentLabel.text = answer[@"title"];
    
    
}


@end
