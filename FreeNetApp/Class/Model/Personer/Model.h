//
//  Model.h
//  FoldTableView
//
//  Created by clearlove on 16/6/21.
//  Copyright © 2016年 belink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property(nonatomic,copy)NSString *headImage;
@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,assign)BOOL isSelect;
@end

@interface GroupModel : NSObject
@property(nonatomic,copy)NSString *myTitle;
@property(nonatomic,copy)NSString *mySelectNum;
@property(nonatomic,assign)BOOL isExpand;
@property(nonatomic,strong)NSMutableArray *myDataArr;
@end