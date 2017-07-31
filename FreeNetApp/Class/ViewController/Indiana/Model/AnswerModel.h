//
//  AnswerModel.h
//  FreeNetApp
//
//  Created by 白华君 on 2017/7/3.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerModel : GoodsModel

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *answers;// 答案数组
@property (nonatomic, assign, readonly) CGFloat cellHeight;
// 图片将要展示的frame
@property (nonatomic, assign) CGRect contentImageFrame;

@property (nonatomic,strong)NSString *rightViewName;

/*
 "data": [
 {
 "id": 5,
 "title": "问题五",
 "answers": [
 {
 "id": 19,
 "title": "问题五答案三",
 "status": true
 },
 {
 "id": 17,
 "title": "问题五答案一",
 "status": false
 },
 {
 "id": 20,
 "title": "问题五答案四",
 "status": false
 },
 {
 "id": 18,
 "title": "问题五答案二",
 "status": false
 }
 ]
 },
 
 
 */
@end
