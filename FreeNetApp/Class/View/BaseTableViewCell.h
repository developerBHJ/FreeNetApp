//
//  BaseTableViewCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonerGroup.h"

@protocol BaseTableViewCellDelegate <NSObject>

@optional

-(void)MethodWithButton:(UIButton *)button index:(NSIndexPath *)index;

-(void)BaseCellMethodWithSwitch:(UISwitch *)sender index:(NSIndexPath *)index;

@end

@interface BaseTableViewCell : UITableViewCell


+(instancetype)initWithTableView:(UITableView *)tableview;

@property (nonatomic,assign)id <BaseTableViewCellDelegate>delegate;
@property (nonatomic,strong)NSIndexPath *index;

-(void)setCellWithModel:(PersonerGroup *)model;


@end


@interface TableViewCellBackgroundView : UIView




@end
