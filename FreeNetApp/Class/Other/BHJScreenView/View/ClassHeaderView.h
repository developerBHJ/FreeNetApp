//
//  ClassHeaderView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/3/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateView.h"
#import "CustomHeaderFooterView.h"
@interface ClassHeaderView : CustomHeaderFooterView

/**
 *  Change to normal state.
 *
 *  @param animated Animated or not.
 */
- (void)normalStateAnimated:(BOOL)animated;

/**
 *  Change to extended state.
 *
 *  @param animated Animated or not.
 */
- (void)extendStateAnimated:(BOOL)animated;

@end
