//
//  EvaluationFooterView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/30.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EvaluationFooterViewBlok)(NSInteger tag);

@interface EvaluationFooterView : UIView
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property(nonatomic,copy)EvaluationFooterViewBlok footerViewAction;

+(EvaluationFooterView *)shareEvaluationFooterView;

@end
