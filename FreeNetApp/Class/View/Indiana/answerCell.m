//
//  answerCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "answerCell.h"
#import "AnswerModel.h"

@implementation answerCell

-(UIView *)backView{

    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        _backView.cornerRadius = 4;
    }
    return _backView;
}

- (UIImageView *)myImageView {
    if (!_myImageView) {
        _myImageView = [[UIImageView alloc] init];
        [self.backView addSubview:_myImageView];
    }
    return _myImageView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cornerRadius = 4;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(AnswerModel *)model {
    
    _model = model;
    self.myLabel.text = _model.title;
    if (model.imageName.length) {
        self.myImageView.hidden = NO;
        self.myImageView.image = [UIImage imageNamed:model.imageName];
        self.backView.frame = _model.contentImageFrame;
        self.myImageView.frame = CGRectMake(15,10, CGRectGetWidth(self.backView.frame) - 30, CGRectGetHeight(self.backView.frame) - 40);
    }else {
        self.myImageView.hidden = YES;
    }
}

@end
