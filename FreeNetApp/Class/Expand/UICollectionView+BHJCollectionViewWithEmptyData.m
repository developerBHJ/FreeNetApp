//
//  UICollectionView+BHJCollectionViewWithEmptyData.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/8/7.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "UICollectionView+BHJCollectionViewWithEmptyData.h"

@implementation UICollectionView (BHJCollectionViewWithEmptyData)

-(NSInteger)showMessage:(NSString *)title byDataSourceCount:(NSInteger)count{
    
    if (count == 0) {
        self.backgroundView=({
            UILabel *label=[[UILabel alloc]init];
            label.text=title;
            label.textColor = [UIColor colorWithHexString:@"#666666"];
            label.textAlignment=NSTextAlignmentCenter;
            label;
        });
        return count;
    }else{
        self.backgroundView=nil;
        return  count;
    }
}


/**
 无数据的情况下显示的页面
 
 @param imageName 图片名
 @param title 提示语
 @param btnStr 按钮名
 @param subContent 副标题
 @param selector 按钮回调方法
 @param frame 图片frame
 @param count 数据源所包含数据个数
 @return 返回数据源所包含数据个数
 */
-(NSInteger)showViewWithImage:(NSString *)imageName alerttitle:(NSString *)title buttonTitle:(NSString *)btnStr subContent:(NSString *)subContent selectore:(SEL)selector
                   imageFrame:(CGRect)frame byDataSourceCount:(NSInteger)count{
    
    if (count == 0) {
     self.backgroundView = [self setViewWithNothingWithImageName:imageName alerntTitle:title buttonTitle:btnStr subContent:subContent selector:selector imageFrame:frame];
        return count;
    }else{
        self.backgroundView = nil;
        return count;
    }
}


-(UIView *)setViewWithNothingWithImageName:(NSString *)image alerntTitle:(NSString *)title buttonTitle:(NSString *)str subContent:(NSString *)content selector:(SEL)selector imageFrame:(CGRect)frame{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
    
    for (UIView *subView in backView.subviews) {
        [subView removeFromSuperview];
    }
    
    backView.backgroundColor = HWColor(241, 241, 241, 1.0);
    UIImageView *notingImage = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    notingImage.frame = frame;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(notingImage.frame) + 10, MainScreen_width - 20, 21)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    [backView addSubview:notingImage];
    if (content != nil) {
        UILabel *subTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 10, MainScreen_width - 20, 21)];
        subTitle.text = content;
        subTitle.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:subTitle];
        subTitle.textColor = [UIColor colorWithHexString:@"#bebebe"];
        UIButton *jumpAction = [UIButton buttonWithType:UIButtonTypeSystem];
        [jumpAction setFrame:CGRectMake(MainScreen_width / 2.5, CGRectGetMaxY(subTitle.frame) + 15, MainScreen_width / 4, 35)];
        [jumpAction setTitle:str forState:UIControlStateNormal];
        [jumpAction setBackgroundColor:[UIColor colorWithHexString:@"#e4504b"]];
        jumpAction.cornerRadius = 5;
        [jumpAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jumpAction addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:jumpAction];
    }
    return backView;
}

@end
