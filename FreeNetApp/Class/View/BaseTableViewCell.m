//
//  BaseTableViewCell.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/11.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UIView+LBExtension.h"
#import "UIScreen+Additions.h"
#import "NSString+Additions.h"
#import "VVeboLabel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface BaseTableViewCell (){

    UIImageView *postBGView;
    UIButton *avatarView;
    UIImageView *cornerImage;
    UIView *topLine;
    VVeboLabel *label;
    VVeboLabel *detailLabel;
    UIScrollView *mulitPhotoScrollView;
    BOOL drawed;
    NSInteger drawColorFlag;
    CGRect commentsRect;
    CGRect repostsRect;
}

@end

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setCellWithModel:(PersonerGroup *)model{


}

+(instancetype)initWithTableView:(UITableView *)tableview{

    return nil;
}

@end


@implementation TableViewCellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, [UIColor colorWithHexString:@"#b2b2b2"].CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(cont, 0, lengths, 2);  //画虚线
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 0.0, rect.size.height - 1);    //开始画线
    CGContextAddLineToPoint(cont, CGRectGetWidth(self.frame), rect.size.height - 1);
    CGContextStrokePath(cont);
    
}



@end
