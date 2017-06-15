//
//  BHJSegementHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/14.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJSegementHeadView.h"

#define MAX_TitleNumInWindow 6
#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)

@interface BHJSegementHeadView ()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;

@end


@implementation BHJSegementHeadView


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    
    self = [super initWithFrame:frame];
    if (self) {
        _btn_w = 0.0;
        if (titleArray.count < MAX_TitleNumInWindow) {
            _btn_w = windowContentWidth / titleArray.count;
        }else{
            _btn_w = windowContentWidth / MAX_TitleNumInWindow;
        }
        _titles = titleArray;
        _defaultIndex = 1;
        _titleFont=[UIFont systemFontOfSize:15];
        _btns=[[NSMutableArray alloc] initWithCapacity:0];
        _titleNomalColor=[UIColor colorWithHexString:@"#696969"];
        _titleSelectColor=[UIColor colorWithHexString:@"#e4504b"];
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.backgroundColor = HWColor(241, 241, 241, 1.0);
//        _bgScrollView.contentSize=CGSizeMake((_btn_w + 10)*titleArray.count, 0);
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(_btn_w * i, 0, _btn_w, CGRectGetHeight(_bgScrollView.frame));
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
//            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            btn.backgroundColor = HWColor(241, 241, 241, 1.0);
            btn.titleLabel.font=_titleFont;
            [_bgScrollView addSubview:btn];
            [_btns addObject:btn];
            if (i != 0) {
                UIImageView *separaterView = [[UIImageView alloc]initWithFrame:CGRectMake((_btn_w - self.separaterSpace )* i , CGRectGetMidY(_bgScrollView.frame) - 5, 8, 10)];
                separaterView.image = [UIImage imageNamed:@"right_arrow"];
                [_bgScrollView addSubview:separaterView];
            }
        }
        [self addSubview:_bgScrollView];
    }
    return self;
}


-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}

-(void)updateView{
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
    }
}

-(void)btnClick:(UIButton *)btn{
    
    
    if (self.block) {
        self.block(btn.tag);
    }
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
    }
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.width-windowContentWidth;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        //        _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height-2, btn.frame.size.width, 2);
        
    } completion:^(BOOL finished) {
    }];
}
@end
