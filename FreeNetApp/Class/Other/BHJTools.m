//
//  BHJTools.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/18.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJTools.h"
#import <AudioToolbox/AudioToolbox.h>

#define DURATION 0.7f

@interface BHJTools ()<CAAnimationDelegate>



@end


@implementation BHJTools

+(BHJTools *)sharedTools{
    
    static BHJTools *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tool = [[BHJTools alloc]init];
    });
    return tool;
}


-(void)pushViewWithFrame:(CGRect)frame content:(NSString *)content{
    
    UIView *backView = [[UIView alloc]initWithFrame:frame];
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(backView.frame), CGRectGetHeight(backView.frame))];
    contentLabel.text = content;
    backView.backgroundColor = HWColor(169, 169, 169, 1.0);
    [backView addSubview:contentLabel];
}

-(JXButton *)creatButtonWithTitle:(NSString *)title image:(NSString *)imageName selector:(SEL)selector Frame:(CGRect)frame viewController:(UIViewController *)viewController selectedImage:(NSString *)selectedImageName tag:(NSInteger)tag{
    
    JXButton *button = [[JXButton alloc]initWithFrame:frame];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"696969"] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button addTarget:viewController action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHexString:@"#e4504b"] forState:UIControlStateSelected];
    return button;
}

-(UIButton *)creatSystomButtonWithTitle:(NSString *)title image:(NSString *)imageName selector:(SEL)selector Frame:(CGRect)frame viewController:(UIViewController *)viewController selectedImage:(NSString *)selectedImageName tag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"696969"] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button addTarget:viewController action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHexString:@"#e4504b"] forState:UIControlStateSelected];
    return button;
}

-(void)setLabelLineSpaceWithLabel:(UILabel *)label space:(CGFloat)space{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//调整行间距
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attStr;
}

-(void)setViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName anotherImage:(NSString *)image viewController:(UIViewController *)viewController selector:(SEL)selector anotherSelector:(SEL)anotherSelector frame:(CGRect)frame anotherFrame:(CGRect)anotherFrame{
    
    UIView *rightView = [[UIView alloc]init];
    rightView.size = frame.size;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [rightBtn setFrame:frame];
    [rightView addSubview:rightBtn];
    //    [rightBtn setTitle:@"+" forState:UIControlStateNormal];
    //    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    //    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightView.contentMode = UIViewContentModeRedraw;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc]init];
    leftView.size = anotherFrame.size;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    //    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [leftBtn setFrame:anotherFrame];
    [leftView addSubview:leftBtn];
    //    [leftBtn setTitle:@"-" forState:UIControlStateNormal];
    //    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:anotherSelector forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentMode = UIViewContentModeRedraw;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}


-(void)shakeView{
    
    SystemSoundID soundId;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Shake" ofType:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundId);
    AudioServicesPlaySystemSound(soundId);
    
}

#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}



#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}


-(void)showShareView{
    // 自定义预设平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withUrl:(NSString *)url
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //    //创建网页内容对象
    //    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"立免网" descr:@"一款专门送东西，带给人快乐的APP" thumImage:url];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}

//#pragma 给View添加背景图
//-(void)addBgImageWithImageName:(NSString *) imageName
//{
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
//}


-(void)alertWithMessage:(NSString *)messgae navigationcontroller:(UINavigationController *)navigationcontroller{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:messgae preferredStyle:UIAlertControllerStyleAlert];
    [navigationcontroller presentViewController:alertVC animated:YES completion:nil];
}
///
-(void)saveDataToSandboxWith:(id)data name:(NSString *)name{
    
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    // 3.新建数据
    NSString *filepath = [docPath stringByAppendingPathComponent:name];
    //NSLog(@"filepath:%@",filepath);
    [data writeToFile:filepath atomically:YES];
}

-(NSArray *)readNSArrayFromSandboxWithName:(NSString *)name{
    
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    // 3.文件路径
    NSString *filepath = [docPath stringByAppendingPathComponent:name];
    // 4.读取数据
    NSArray *data = [NSArray arrayWithContentsOfFile:filepath];
    return data;
}

-(NSDictionary *)readNSDictionaryFromSandboxWithName:(NSString *)name{
    
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    // 3.文件路径
    NSString *filepath = [docPath stringByAppendingPathComponent:name];
    // 4.读取数据
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:filepath];
    return data;
}











@end
