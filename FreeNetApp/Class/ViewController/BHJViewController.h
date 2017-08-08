//
//  BHJViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BHJViewControllerStatu) {
    
    BHJViewControllerStatuFree,
    BHJViewControllerStatuSpecial,
    BHJViewControllerStatuIndiana,
    BHJViewControllerStatuCoupon,
    BHJViewControllerStatuOpen
};


@interface BHJViewController : UIViewController<BaseTableViewCellDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong)NSString *navgationTitle;
@property (nonatomic,strong)NSString *leftBtnTitle;
@property (nonatomic,strong)NSString *leftImage;
@property (nonatomic,strong)NSString *leftBtnTitle_1;
@property (nonatomic,strong)UIButton *locationBtn;

@property (nonatomic,retain)CLLocationManager *locationManager;

@property (nonatomic,assign)BHJViewControllerStatu viewControllerStatu;
/*
 界面无数据时的布局
 image  无数据时显示的图片
 title  提示语
 str    按钮标题
 content 提示更多信息
 selector 按钮的回调方法
 frame 图片frame ,其他控件根据图片的frame布局
 按钮和subTitle标题为空时隐藏
 */
-(void)setViewWithNothingWithImageName:(NSString *)image alerntTitle:(NSString *)title buttonTitle:(NSString *)str subContent:(NSString *)content selector:(SEL)selector imageFrame:(CGRect)frame;

// 设置导航栏
-(void)setNavgationBarView;
// 获取定位信息
-(void)getLocationData;

-(void)settleAreaData;

@end
