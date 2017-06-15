//
//  BHJScreenView.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/3/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NormalAnimation(_inView,_duration,_option,_frames)            [UIView transitionWithView:_inView duration:_duration options:_option animations:^{ _frames    }

typedef void (^BHJActionBlock)(int section,int row);

@interface BHJScreenView : BHJCustomView{

    BHJActionBlock completionBlock;
}

@property (nonatomic,strong)NSArray *dataArr;
-(void)showScreenViewSetCompletionBlock:(BHJActionBlock)aCompletionBlock;

@end
