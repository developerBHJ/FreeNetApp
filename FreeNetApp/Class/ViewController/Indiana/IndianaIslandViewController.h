//
//  IndianaIslandViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/12.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndianaDetailModel.h"
@interface IndianaIslandViewController : BHJViewController

@property (nonatomic,strong)IndianaDetailModel *detailModel;

-(instancetype)initWithID:(IndianaDetailModel *)model;

@end
