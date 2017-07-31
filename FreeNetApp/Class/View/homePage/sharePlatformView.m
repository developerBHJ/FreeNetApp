//
//  sharePlatformView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "sharePlatformView.h"

@implementation sharePlatformView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

+(sharePlatformView *)shareSharePlatformView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"sharePlatformView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


- (IBAction)dismiss:(UIButton *)sender {
    
    [self removeFromSuperview];
}

- (IBAction)sinaShare:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}

- (IBAction)cicrleShare:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}


- (IBAction)qqShare:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}

- (IBAction)tencentWeiboShare:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}

- (IBAction)messageShare:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}

- (IBAction)webChartShare:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}

- (IBAction)renrenShare:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}


- (IBAction)location:(UIButton *)sender {
    
    if (self.block) {
        self.block(sender.tag);
    }
}

-(void)setView{
    
    self.closeBtn.layer.cornerRadius = CGRectGetWidth(self.closeBtn.frame) / 2;
    self.closeBtn.layer.masksToBounds = YES;
    self.closeBtn.borderColor = [UIColor whiteColor];
    self.closeBtn.borderWidth = 2;
    
    self.sinaLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.sinaLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.webCahrtLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.webCahrtLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.cicrleLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.cicrleLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.QQLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.QQLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.renrenLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.renrenLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.tencentLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.tencentLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.messageLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    [self.messageLabel setFont:[UIFont systemFontOfSize:12]];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.sinaBtn.tag = 2000;
    self.webChartBtn.tag = 2001;
    self.cicrleBtn.tag = 2002;
    self.qqBtn.tag = 2003;
    self.renrenBtn.tag = 2004;
    self.tencentBtn.tag = 2005;
    self.messageBtn.tag = 2006;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

-(void)returnButtonTag:(platformViewBlock)block{
    
    self.block = block;
}


-(void)tapAction:(UITapGestureRecognizer *)sender{
    
    [self removeFromSuperview];
}


-(void)setProduct:(OpenGoods *)product{
    
    _product = product;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:product.goods[@"cover_url"]]];
    self.goods_name.text = product.goods[@"title"];
    self.store_name.text = product.shop[@"title"];
    self.storeAddress.text = product.shop[@"address"];
}

@end
