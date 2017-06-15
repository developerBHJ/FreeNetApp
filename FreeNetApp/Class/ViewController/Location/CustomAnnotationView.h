//
//  CustomAnnotationView.h
//  Unicorn
//
//  Created by zhupeng on 16/5/6.
//  Copyright © 2016年 bhj_jun. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@protocol CustomAnnotationViewDelegate <NSObject>

-(void)findRoudWintAdress:(NSString *)adress;

@end

@interface CustomAnnotationView : MAPinAnnotationView



@property (nonatomic, readonly) CustomCalloutView *calloutView;

@property (nonatomic,assign)id<CustomAnnotationViewDelegate>delegate;

@end
