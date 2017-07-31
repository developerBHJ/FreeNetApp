//
//  couponHeadView.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,couponHeaderViewStyle){
    
   couponHeaderViewStyleWithNomal,
   couponHeaderViewStyleWithLeft,
   couponHeaderViewStyleWithMiddle,
   couponHeaderViewStyleWithRight
};

@protocol couponHeadViewDelegate <NSObject>

-(void)couponHeadViewMethodWith:(couponHeaderViewStyle)viewStyle selectRow:(NSInteger)row selectedItem:(NSInteger)item;

@end


@interface couponHeadView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIButton *sortBtn;
@property (nonatomic,strong)NSMutableArray *leftData;
@property (nonatomic,strong)NSMutableArray *middleData;
@property (nonatomic,strong)NSMutableArray *rightData;
@property (nonatomic,strong)NSMutableArray *tempData;
@property (nonatomic,assign)BOOL isCoupon;
@property (nonatomic,assign)couponHeaderViewStyle headerViewStatue;
@property (nonatomic,assign)id <couponHeadViewDelegate> delegate;
/**左边菜单内cell的高度*/
@property (nonatomic,assign) NSInteger leftMenuSubViewHeight;
/**中间菜单内cell的高度*/
@property (nonatomic,assign) NSInteger middleMenuSubViewHeight;
/**右边菜单内cell的高度*/
@property (nonatomic,assign) NSInteger rightMenuSubViewHeight;

- (void)removeMenu;
+(couponHeadView *)shareCouponHeadView;

@end
