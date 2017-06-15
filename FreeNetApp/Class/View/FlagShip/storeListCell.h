//
//  storeListCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/27.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface storeListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *store_name;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;







@end
