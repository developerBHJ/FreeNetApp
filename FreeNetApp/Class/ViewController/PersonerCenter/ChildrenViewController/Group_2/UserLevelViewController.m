//
//  UserLevelViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/22.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "UserLevelViewController.h"
#import "UserLevelHeadView.h"
#import "AccelerationViewController.h"

@interface UserLevelViewController ()<UIWebViewDelegate>

@end

@implementation UserLevelViewController
#pragma mark >>>>> 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setView];
    
    [self levelExplainWithURL:@"http://192.168.0.254:1000/personer/level"];
}

#pragma mark >>>>> 自定义
-(void)setView{

    self.navigationItem.title = @"等级说明";
    
//    UserLevelHeadView *headView = [UserLevelHeadView shareCouponHeadView];
//    headView.frame = CGRectMake(10, 74, kScreenWidth - 20, kScreenHeight / 4.5);
//    [self.view addSubview:headView];
//    headView.layer.cornerRadius = 5;
//    headView.layer.masksToBounds = YES;
//    [headView.progressBtn addTarget:self action:@selector(acceleration:) forControlEvents:UIControlEventTouchUpInside];
//    headView.progress.progress = 0.4;
//    headView.markViewLeadingX.constant = headView.progress.progress * CGRectGetWidth(headView.progress.frame) * 0.98;
 
    UIWebView *contentView = [[UIWebView alloc]initWithFrame:CGRectMake(10, kScreenHeight / 4.5 + 84, kScreenWidth - 20, kScreenHeight - kScreenHeight / 4.5 - 84)];
    [contentView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.limian.com/help/index/?id=1"]]];
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
}

// 等级加速
-(void)acceleration:(UIButton *)sender{

    AccelerationViewController *accelerationVC = [[AccelerationViewController alloc]init];
    [self.navigationController pushViewController:accelerationVC animated:YES];
}

#pragma mark >>>>> 自定义
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:
                                                     @"var script = document.createElement('script');"
                                                     "script.type = 'text/javascript';"
                                                     "script.text = \"function ResizeImages() { "
                                                     "var myimg,oldwidth;"
                                                     "var maxwidth = %g;" // UIWebView中显示的宽度
                                                     "for(i=0;i <document.images.length;i++){"
                                                     "myimg = document.images[i];"
                                                     "if(myimg.width > maxwidth){"
                                                     "oldwidth = myimg.width;"
                                                     "myimg.width = maxwidth;"
                                                     "}"
                                                     "}"
                                                     "}\";"
                                                     "document.getElementsByTagName('head')[0].appendChild(script);",self.view.frame.size.width]];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"divs = document.getElementsByTagName('div');\
     for(i = 0; i < divs.length; i++) {\
     if (divs[i].className =='info') {\
     divs[i].parentNode.removeChild(divs[i]);\
     }\
     }\
     "];
}



#pragma mark - 数据请求 等级说明
-(void)levelExplainWithURL:(NSString *)url{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:user_id forKey:@"userId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
        UserLevelHeadView *headView = [UserLevelHeadView shareCouponHeadView];
        headView.frame = CGRectMake(10, 74, kScreenWidth - 20, kScreenHeight / 4.5);
        [self.view addSubview:headView];
        headView.layer.cornerRadius = 5;
        headView.layer.masksToBounds = YES;
        [headView.progressBtn addTarget:self action:@selector(acceleration:) forControlEvents:UIControlEventTouchUpInside];
        headView.progress.progress = 0.4;
        headView.markViewLeadingX.constant = headView.progress.progress * CGRectGetWidth(headView.progress.frame) * 0.98;
        
        //赋值
        headView.user_name.text = result[@"realname"];//昵称
        headView.currentLevel.text = result[@"name"];//当前等级
        headView.levelLabel.text = result[@"nextname"];//升级等级
        headView.number.text = result[@"growing"];//当前经验值
        [headView.user_image sd_setImageWithURL:result[@"portrait"]];//用户头像
        //[headView.levelImage sd_setImageWithURL:result[@""]];//用户等级
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ShowMessage showMessage:@"网络异常" duration:3];
    }];
}









@end
