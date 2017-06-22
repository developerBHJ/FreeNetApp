//
//  MyCollectionCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/16.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionModel.h"
@interface MyCollectionCell : BaseTableViewCell

@property (nonatomic,strong)AttentionModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *storeLogoImage;   //图片

@property (weak, nonatomic) IBOutlet UILabel *addressLabel; //地址

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;    //电话

@property (weak, nonatomic) IBOutlet UILabel *storeName;    //商店名

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;  //附属

@property (nonatomic,strong)NSString *iphoneNum;    //电话号码
@end
