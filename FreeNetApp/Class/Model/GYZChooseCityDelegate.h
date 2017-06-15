//
//  GYZChooseCityDelegate.h
//  GYZChooseCityDemo
//  选择城市相关delegate
//  Created by wito on 15/12/29.
//  Copyright © 2015年 gouyz. All rights reserved.
//

@class GYZCity;
@class LocationViewController;

@protocol ChooseCityDelegate <NSObject>

- (void) cityPickerController:(LocationViewController *)chooseCityController
                didSelectCity:(GYZCity *)city;

- (void) cityPickerControllerDidCancel:(LocationViewController *)chooseCityController;

@end

@protocol CityGroupCellDelegate <NSObject>

- (void) cityGroupCellDidSelectCity:(GYZCity *)city;

@end
