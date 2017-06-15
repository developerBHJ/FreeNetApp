//
//  BHJDropView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHJDropModel.h"

#define WSNoFound (-1)

@interface BHJIndexPath : NSObject

@property (nonatomic,assign) NSInteger column; //区分  0 为左边的   1 是 右边的
@property (nonatomic,assign) NSInteger row; //左边第一级的行
@property (nonatomic,assign) NSInteger item; //左边第二级的行

+ (instancetype)twIndexPathWithColumn:(NSInteger )column
                                  row:(NSInteger )row
                                 item:(NSInteger )item;

@end

@class BHJDropView;

@protocol BHJDropViewDataSource <NSObject>


- (NSInteger )dropMenuView:(BHJDropView *)dropMenuView numberWithIndexPath:(BHJIndexPath *)indexPath;

- (NSString *)dropMenuView:(BHJDropView *)dropMenuView titleWithIndexPath:(BHJIndexPath *)indexPath;


@end

@protocol BHJDropViewDelegate <NSObject>


- (void)dropMenuView:(BHJDropView *)dropMenuView didSelectWithIndexPath:(BHJIndexPath *)indexPath;


@end

@interface BHJDropView : UIView

@property (nonatomic,weak) id<BHJDropViewDataSource> dataSource;
@property (nonatomic,weak) id<BHJDropViewDelegate> delegate;

- (void)reloadLeftTableView;

- (void)reloadRightTableView;



@end
