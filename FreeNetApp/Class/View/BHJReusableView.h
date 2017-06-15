//
//  BHJReusableView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/24.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BHJReusableViewDelegate <NSObject>

@optional
-(void)BHJReusableViewDelegateMethodWithIndexPath:(NSIndexPath *)indexPath button:(UIButton *)button;

@end

@interface BHJReusableView : UICollectionReusableView

@property (nonatomic,strong)UIViewController *viewController;
@property (nonatomic,assign)id <BHJReusableViewDelegate>delegate;
@property (nonatomic,strong)NSIndexPath *indexPath;

@end
