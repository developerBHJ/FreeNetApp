//
//  discountCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/12/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "discountCell.h"

@implementation discountCell

-(UIView *)photoView{

    if (!_photoView) {
        _photoView = [[PYPhotosView alloc]init];
        _photoView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_photoView];
    }
    return _photoView;
}




- (void)awakeFromNib {
    [super awakeFromNib];

    self.prePrice.lineType = LineTypeMiddle;

}


- (IBAction)vertification:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
}

- (IBAction)collection:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MethodWithButton:indexPath:)]) {
        [self.delegate MethodWithButton:sender indexPath:self.index];
    }
    self.commitNum.text = @"29";
    [sender setImage:[[UIImage imageNamed:@"star_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}



-(void)setModel:(discountModel *)model{

    _model = model;
    self.contentLable.text = _model.content;
    //调整行间距
    [[BHJTools sharedTools]setLabelLineSpaceWithLabel:self.contentLable space:3];
    //如果没有图片则隐藏 图片View
    if (self.model.imageAr.count > 0) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.model.contentImageFrame;
        CGFloat imageW = self.photoView.width / 5;
        NSMutableArray *imageArr = [NSMutableArray new];
        for (int i = 0; i < self.model.imageAr.count; i ++) {
            NSString *str = self.model.imageAr[i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageW * i, 0, imageW, self.photoView.height)];
            imageView.image = [UIImage imageNamed:str];
            //            [self.photosView addSubview:imageView];
            [imageArr addObject:imageView.image];
        }
        //        // 设置图片缩略图数组
        //        self.photosView.thumbnailUrls = [self.momentFrames.moment.photos objectAtIndex:0];
        //        // 设置图片原图地址
        //        self.photosView.originalUrls = [self.momentFrames.moment.photos objectAtIndex:1];
        self.photoView.images = imageArr;
    }else{
        self.photoView.hidden = YES;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}




@end
