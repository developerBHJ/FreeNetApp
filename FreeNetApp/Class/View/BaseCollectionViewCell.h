//
//  BaseCollectionViewCell.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/16.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@protocol BaseCollectionViewCellDelegate <NSObject>

@optional
-(void)MethodWithButton:(UIButton *)button indexPath:(NSIndexPath *)index;

@end

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign)id <BaseCollectionViewCellDelegate>delegate;
@property (nonatomic,strong)NSIndexPath *index;

-(void)setCellWithModel:(BaseModel *)model;



@end

@interface CollectionViewBackgroundView : UIView




@end

