//
//  BHJTools.h
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//
#import "JXButton.h"
#import <Foundation/Foundation.h>

@interface BHJTools : NSObject

+(BHJTools *)sharedTools;


-(void)pushViewWithFrame:(CGRect)frame content:(NSString *)content;

-(JXButton *)creatButtonWithTitle:(NSString *)title image:(NSString *)imageName selector:(SEL)selector Frame:(CGRect)frame viewController:(UIViewController *)viewController selectedImage:(NSString *)selectedImageName tag:(NSInteger)tag;

-(UIButton *)creatSystomButtonWithTitle:(NSString *)title image:(NSString *)imageName selector:(SEL)selector Frame:(CGRect)frame viewController:(UIViewController *)viewController selectedImage:(NSString *)selectedImageName tag:(NSInteger)tag;

-(void)setViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName anotherImage:(NSString *)image viewController:(UIViewController *)viewController selector:(SEL)selector anotherSelector:(SEL)anotherSelector frame:(CGRect)frame anotherFrame:(CGRect)anotherFrame;


// 设置label行间距
-(void)setLabelLineSpaceWithLabel:(UILabel *)label space:(CGFloat)space;

// 手机振动
-(void)shakeView;

// 分享
-(void)showShareView;

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withUrl:(NSString *)url;


-(void)saveDataToSandboxWith:(id)data name:(NSString *)name;

-(NSArray *)readNSArrayFromSandboxWithName:(NSString *)name;
-(NSDictionary *)readNSDictionaryFromSandboxWithName:(NSString *)name;

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date;
//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format;
//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format;


@end
