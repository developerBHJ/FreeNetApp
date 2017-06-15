//
//  EvaluationCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyTapAction)(NSInteger tag);

@interface EvaluationCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic,copy) MyTapAction block;

-(void)upDataWithHead:(NSString *)headImage andTitle:(NSString *)title andIsselected:(BOOL) isSelect;
//点击更新button的选中与否
-(void)updateWithSelectSatic;


@end
