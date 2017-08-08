//
//  indianaBottomView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/15.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "indianaBottomView.h"

@implementation indianaBottomView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
    }
    return self;
}

-(void)layoutSubviews{

    self.mySwitch.on = YES;
    CGFloat gold = [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_gold"] floatValue];
    self.balanceNum.text = [@"¥" stringByAppendingFormat:@"%.2f",gold];
    [self isOpen:self.mySwitch];
    self.mySwitch.enabled = NO;
    [self layoutIfNeeded];
}

+(indianaBottomView *)shareIndianaBottomView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"indianaBottomView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}

- (IBAction)isOpen:(UISwitch *)sender {
    
    if (!sender.on) {
        self.chargeBtn.hidden = YES;
        self.themeLabel.text = @"自动出价";
        self.titleLabel.text = @"自动出价";
        self.currentLabel.hidden = NO;
        self.currentPrice.hidden = NO;
        self.topPrice.hidden = NO;
        self.secondTF.hidden = NO;
        self.saveBtn.hidden = NO;
        self.secondLabel.hidden = NO;
        self.firstLabel.text = @"加价幅度";
        self.contentView.frame = CGRectMake(0, self.height - self.height / 3, self.width, self.height / 3);
    }else{
        self.chargeBtn.hidden = NO;
        self.themeLabel.text = @"手动出价";
        self.titleLabel.text = @"手动出价";
        self.currentLabel.hidden = YES;
        self.currentPrice.hidden = YES;
        self.topPrice.hidden = YES;
        self.secondTF.hidden = YES;
        self.saveBtn.hidden = YES;
        self.firstLabel.text = @"出价金额";
        self.secondLabel.hidden = YES;
    //    self.contentView.frame = CGRectMake(0, self.height - self.height / 4, self.width, self.height / 4);
    }
}

- (IBAction)saveAction:(UIButton *)sender {
    
    NSLog(@"保存");
}

- (IBAction)chargeAction:(UIButton *)sender {
    
    NSLog(@"出价");
}

- (IBAction)viewDismiss:(UIButton *)sender {
    
    [self removeFromSuperview];
}

@end
