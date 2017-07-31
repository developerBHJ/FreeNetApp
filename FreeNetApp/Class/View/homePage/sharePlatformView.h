//
//  sharePlatformView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGoods.h"
typedef void(^platformViewBlock)(NSInteger btnTag);

@interface sharePlatformView : UIView

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *titleView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *cicrleBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *tencentBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *webChartBtn;
@property (weak, nonatomic) IBOutlet UIButton *renrenBtn;
@property (weak, nonatomic) IBOutlet UILabel *webCahrtLabel;
@property (weak, nonatomic) IBOutlet UILabel *cicrleLabel;
@property (weak, nonatomic) IBOutlet UILabel *QQLabel;
@property (weak, nonatomic) IBOutlet UILabel *renrenLabel;
@property (weak, nonatomic) IBOutlet UILabel *tencentLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *sinaLabel;
@property (weak, nonatomic) IBOutlet UIView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_subTitle;
@property (weak, nonatomic) IBOutlet UILabel *store_name;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;

@property (nonatomic,copy)platformViewBlock block;

+(sharePlatformView *)shareSharePlatformView;

-(void)setView;
- (void)returnButtonTag:(platformViewBlock)block;

@property (nonatomic,strong)OpenGoods *product;

@end
