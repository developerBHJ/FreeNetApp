//
//  EvaluationHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyTapAction)(NSInteger tag);

@interface EvaluationHeadView : UIView

@property(nonatomic,copy)MyTapAction myTapAction;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property(nonatomic,assign)BOOL isOpen;
@property (nonatomic,assign)NSInteger section;

+(EvaluationHeadView *)shareEvaluationHeadView;

@end
