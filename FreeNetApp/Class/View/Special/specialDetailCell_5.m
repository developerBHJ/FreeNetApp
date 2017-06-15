//
//  specialDetailCell_5.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/20.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "specialDetailCell_5.h"
@implementation specialDetailCell_5

-(UIView *)photosView{

    if (!_photosView) {
        _photosView = [PYPhotosView photosView];
        _photosView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_photosView];
    }
    return _photosView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.ratingView setImageDeselected:@"star_half" halfSelected:nil fullSelected:@"star_red" andDelegate:nil];
    [self.ratingView displayRating:4];
    self.ratingView.isIndicator = YES;

}

- (void)setModel:(BaseModel *)model {
    
    _model = model;
    self.contentLabel.text = _model.content;
    //调整行间距
    [[BHJTools sharedTools]setLabelLineSpaceWithLabel:self.contentLabel space:3];
    //如果没有图片则隐藏 图片View
    if (self.model.imageAr.count > 0) {
        self.photosView.hidden = NO;
        self.photosView.frame = CGRectMake(10, self.contentLabel.bottom + 15, _model.contentImageFrame.size.width, _model.contentImageFrame.size.height);
        CGFloat imageW = self.photosView.width / 5;
        for (int i = 0; i < self.model.imageAr.count; i ++) {
            NSString *str = self.model.imageAr[i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageW * i, 5, imageW, self.photosView.height - 10)];
            imageView.image = [UIImage imageNamed:str];
            [imageView imageFillImageView];
            [self.photosView addSubview:imageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            imageView.tag = 2000 + i;
        }
    }else{
        self.photosView.hidden = YES;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)imageClick:(UITapGestureRecognizer *)sender{
    
    PYPhotoBrowseView *browseView = [[PYPhotoBrowseView alloc]init];
    UIView *imageView = [sender view];
    NSMutableArray *imageArr = [NSMutableArray new];
    for (int i = 0; i < self.model.imageAr.count; i ++) {
        NSString *str = self.model.imageAr[i];
        UIImage *image = [UIImage imageNamed:str];
        [imageArr addObject:image];
    }
    browseView.images = imageArr;
    browseView.currentIndex = imageView.tag - 2000;
    [browseView show];
}
@end
