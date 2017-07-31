//
//  BerserkHistoryViewController.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/9.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HistoryViewStatus) {
    
    HistoryViewStatusWithBerserk,
    HistoryViewStatusWithIndiana
};
@interface BerserkHistoryViewController : BHJViewController

@property (nonatomic,assign)HistoryViewStatus historyState;

-(id)initWithID:(NSNumber *)lid;

@end
