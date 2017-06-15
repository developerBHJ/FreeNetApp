//
//  BHJMultistageTableViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef MB_STRONG
#if __has_feature(objc_arc)
#define MB_STRONG strong
#else
#define MB_STRONG retain
#endif
#endif

#ifndef MB_WEAK
#if __has_feature(objc_arc_weak)
#define MB_WEAK weak
#elif __has_feature(objc_arc)
#define MB_WEAK unsafe_unretained
#else
#define MB_WEAK assign
#endif
#endif

@protocol BHJMultistageDelegate <NSObject>

-(void) didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface BHJMultistageTableViewController : UITableViewController

- (id)initWithMenuSections:(NSArray *) menuSections;
@property (MB_WEAK) id<BHJMultistageDelegate> delegate;




@end
