//
//  QuickspotView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/10.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface QuickspotView : BHJCustomView


@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *webChartBtn;
@property (weak, nonatomic) IBOutlet UIButton *webCicrleBtn;
@property (weak, nonatomic) IBOutlet UIButton *tencentBtn;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;

-(void)addButtonOnSubView:(UIView *)subView;

+(QuickspotView *)shareQuickspotView;

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSMutableArray *coordinates;

@end
