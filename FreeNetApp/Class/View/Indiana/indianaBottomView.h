//
//  indianaBottomView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/15.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface indianaBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstTF;
@property (weak, nonatomic) IBOutlet UILabel *topPrice;
@property (weak, nonatomic) IBOutlet UITextField *secondTF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *balanceNum;
@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;




+(indianaBottomView *)shareIndianaBottomView;

@end
