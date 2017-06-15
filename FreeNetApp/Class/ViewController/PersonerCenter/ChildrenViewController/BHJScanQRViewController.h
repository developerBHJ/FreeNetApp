//
//  BHJScanQRViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBXScanViewController.h"
#import "LBXAlertAction.h"

@interface BHJScanQRViewController : LBXScanViewController

#pragma mark -模仿qq界面
@property (nonatomic, assign) BOOL isQQSimulator;

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property (nonatomic, assign) BOOL isVideoZoom;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;



@end
