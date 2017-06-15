//
//  ZYLPickerView.h
//  PickerView
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "city.h"

@interface ZYLPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

/**
 *  存放数据的数组
 */
@property (nonatomic,strong)NSArray *citiesArray;

/**
 *  pickerview
 */
@property (strong, nonatomic) UIPickerView *pickerView;

/**
 *  省市 城市名称 文本
 */
@property (strong, nonatomic) UILabel *lbProCityName;

/**
 *  省市 城市名称
 */
@property (copy, nonatomic) NSString *proCityName;

/**
 *  省模型
 */
@property (nonatomic,strong)city * selecletPro;

/**
 *  取消按钮
 */
@property (strong, nonatomic) UIButton *cancelBtn;

/**
 *  确定按钮
 */
@property (strong, nonatomic) UIButton *confirmBtn;

/**
 *  删除视图
 */
-(void)disMiss;

@property (nonatomic,copy) void(^SelectBlock)(NSString *procityName);


@end
