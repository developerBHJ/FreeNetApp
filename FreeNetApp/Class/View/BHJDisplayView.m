//
//  BHJDisplayView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJDisplayView.h"


@interface BHJDisplayView () <UIScrollViewDelegate>{

    UIScrollView    *_bigScrollView;
    NSMutableArray  *_imageArray;
    UIPageControl   *_pageControl;
}

@end

@implementation BHJDisplayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = [@[@"luanchView_1.png",@"luanchView_2.png", @"luanchView_3.png",@"luanchView_4.png"]mutableCopy];
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
        
        scrollView.contentSize = CGSizeMake((_imageArray.count + 1)*MainScreen_width, MainScreen_height);
        scrollView.pagingEnabled = YES;//设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _bigScrollView = scrollView;
        
        for (int i = 0; i < _imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(i * MainScreen_width, 0, MainScreen_width, MainScreen_height);
            UIImage *image = [UIImage imageNamed:_imageArray[i]];
            imageView.image = image;
            [scrollView addSubview:imageView];
        }
        
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(MainScreen_width/2, MainScreen_height - 60, 0, 40)];
        pageControl.numberOfPages = _imageArray.count;
        pageControl.backgroundColor = [UIColor clearColor];
        
        _pageControl = pageControl;
        
        //添加手势
        UITapGestureRecognizer *singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
        singleRecognizer.numberOfTapsRequired = 1;
        [scrollView addGestureRecognizer:singleRecognizer];
    }
    return self;
}

-(void)handleSingleTapFrom
{
    if (_pageControl.currentPage == 3) {
        self.hidden = YES;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bigScrollView) {
        
        CGPoint offSet = scrollView.contentOffset;
        
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
    }
    if (scrollView.contentOffset.x == (_imageArray.count) * MainScreen_width) {
        
        self.hidden = YES;
        
    }
    
}

@end
