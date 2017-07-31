//
//  couponHeadView.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/26.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "couponHeadView.h"
#import "BHJDropModel.h"
#import "couponDropViewCell.h"
#import "couponClassCell.h"

#define kDefault -1

@interface couponHeadView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _currSelecRow;
    NSInteger _currSelecItem;
    NSInteger _currSelectedColum;
    
}
/**
 *  最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton *cover;
/**记录按钮是否被选中*/
@property (nonatomic,assign,getter=isSelected) BOOL btnSelected;

@property (nonatomic,strong)UITableView *leftView;
@property (nonatomic,strong)UITableView *rightView;

@end

@implementation couponHeadView

-(UITableView *)leftView{
    
    if (!_leftView) {
        _leftView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, 0) style:UITableViewStylePlain];
        _leftView.delegate = self;
        _leftView.dataSource = self;
        [_leftView registerNib:[UINib nibWithNibName:@"couponDropViewCell" bundle:nil] forCellReuseIdentifier:@"couponDropViewCell"];
        [_leftView registerNib:[UINib nibWithNibName:@"couponClassCell" bundle:nil] forCellReuseIdentifier:@"couponClassCell"];
        _leftView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        _leftView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _leftView;
}

-(UITableView *)rightView{
    
    if (!_rightView) {
        _rightView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, 0) style:UITableViewStylePlain];
        _rightView.delegate = self;
        _rightView.dataSource = self;
        [_rightView registerNib:[UINib nibWithNibName:@"couponDropViewCell" bundle:nil] forCellReuseIdentifier:@"couponDropViewCell"];
        _rightView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        _rightView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _rightView;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.allBtn setImage:[[UIImage imageNamed:@"coupon_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.locationBtn setImage:[[UIImage imageNamed:@"location_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.sortBtn setImage:[[UIImage imageNamed:@"sort"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.headerViewStatue = couponHeaderViewStyleWithNomal;
        _currSelecItem = kDefault;
        _currSelecRow = kDefault;
        _currSelectedColum = 0;
    }
    return self;
}



+(couponHeadView *)shareCouponHeadView{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"couponHeadView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

/**
 *  添加遮盖
 */
- (void)setupCover
{
    // 添加一个遮盖按钮
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIButton *cover = [[UIButton alloc] init];
    CGFloat coverY = self.frame.size.height + self.frame.origin.y;
    cover.frame = CGRectMake(0, coverY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.3;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:cover];
    self.cover = cover;
}

/**
 *  点击了底部的遮盖，遮盖消失
 */
- (void)coverClick
{
    self.btnSelected = NO;  // 点击遮盖后让该属性变为no，如果不设置需要点击按钮2次才能进入菜单页面
    [self removeMenu];
}

/**
 *  菜单消失
 */
- (void)removeMenu
{
    self.firstImage.transform = CGAffineTransformMakeRotation(0);
    self.secondImage.transform = CGAffineTransformMakeRotation(0);
    self.thirdImage.transform = CGAffineTransformMakeRotation(0);
    
    [self.allBtn setImage:[UIImage imageNamed:@"coupon_0"] forState:UIControlStateNormal];
    [self.locationBtn setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
    [self.sortBtn setImage:[UIImage imageNamed:@"sort"] forState:UIControlStateNormal];
    
    [self.allBtn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
    [self.locationBtn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
    [self.sortBtn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
    [self.leftView removeFromSuperview];
    [self.rightView removeFromSuperview];
    _currSelecItem = kDefault;
    _currSelecRow = kDefault;
    _currSelectedColum = 0;
    [self.cover removeFromSuperview];
}

- (IBAction)allAction:(UIButton *)sender {
    
    self.btnSelected = !self.isSelected;
    self.headerViewStatue = couponHeaderViewStyleWithLeft;
    if (self.btnSelected) {
        [self setupCover];
        self.firstImage.transform = CGAffineTransformMakeRotation(M_PI);
        [self.allBtn setTitleColor:[UIColor colorWithHexString:@"#e4504b"] forState:UIControlStateNormal];
        self.leftView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (self.isCoupon) {
            self.leftView.frame = CGRectMake(0, self.bottom + 1, MainScreen_width / 2, 42.5 * self.leftData.count);
            self.rightView.frame = CGRectMake(MainScreen_width / 2, self.bottom + 1, MainScreen_width / 2, 42.5 * self.leftData.count);
            [UIView animateWithDuration:0.2 animations:^{
                [window addSubview:self.leftView];
                [window addSubview:self.rightView];
                [self.leftView reloadData];
                [self.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                [self.tempData removeAllObjects];
                BHJDropModel *model = self.leftData[0];
                self.tempData = [NSMutableArray arrayWithArray:model.items];
                [self.rightView reloadData];
            }];
        }else{
            self.leftView.frame = CGRectMake(0, self.bottom + 1, MainScreen_width, 42.5 * self.leftData.count);
            [UIView animateWithDuration:0.2 animations:^{
                [window addSubview:self.leftView];
                [self.leftView reloadData];
            }];
        }
        
    }else{
        [self removeMenu];
    }
}

- (IBAction)location:(UIButton *)sender {
    
    self.btnSelected = !self.isSelected;
    self.headerViewStatue = couponHeaderViewStyleWithMiddle;
    if (self.btnSelected) {
        [self setupCover];
        self.secondImage.transform = CGAffineTransformMakeRotation(M_PI);
        [self.locationBtn setTitleColor:[UIColor colorWithHexString:@"#e4504b"] forState:UIControlStateNormal];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.rightView.frame = CGRectMake(0, self.bottom + 1, MainScreen_width, 42.5 * self.middleData.count);
        
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        [UIView animateWithDuration:0.2 animations:^{
            [window addSubview:self.rightView];
            [self.rightView reloadData];
        }];
    }else{
        [self removeMenu];
    }
}

- (IBAction)sort:(UIButton *)sender {
    
    self.btnSelected = !self.isSelected;
    self.headerViewStatue = couponHeaderViewStyleWithRight;
    if (self.btnSelected) {
        [self setupCover];
        self.thirdImage.transform = CGAffineTransformMakeRotation(M_PI);
        [self.sortBtn setTitleColor:[UIColor colorWithHexString:@"#e4504b"] forState:UIControlStateNormal];
        [self.sortBtn setImage:[UIImage imageNamed:@"sort_red"] forState:UIControlStateNormal];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.rightView.frame = CGRectMake(0, self.bottom + 1, MainScreen_width, 42.5 * self.rightData.count);
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        [UIView animateWithDuration:0.2 animations:^{
            [window addSubview:self.rightView];
            [self.rightView reloadData];
        }];
    }else{
        [self removeMenu];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    /*
     if (self.headerViewStatue == couponHeaderViewStyleWithLeft && tableView == self.rightView) {
     return self.tempData.count;
     }
     */
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.headerViewStatue == couponHeaderViewStyleWithLeft && tableView == self.leftView) {
        return self.leftData.count;
    }else if (self.headerViewStatue == couponHeaderViewStyleWithLeft && tableView == self.rightView){
        return self.tempData.count;
    }else if (self.headerViewStatue == couponHeaderViewStyleWithMiddle && tableView == self.leftView){
        return self.middleData.count;
    }else if (self.headerViewStatue == couponHeaderViewStyleWithMiddle && tableView == self.rightView){
        return self.middleData.count;
    }else if(self.headerViewStatue == couponHeaderViewStyleWithRight && tableView == self.rightView){
        return self.rightData.count;
    }
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.headerViewStatue == couponHeaderViewStyleWithLeft && tableView == self.leftView) {
        couponClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponClassCell" forIndexPath:indexPath];
        cell.model = self.leftData[indexPath.row];
        return cell;
    }else if (self.headerViewStatue == couponHeaderViewStyleWithLeft && tableView == self.rightView){
        couponDropViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponDropViewCell" forIndexPath:indexPath];
        cell.model = self.tempData[indexPath.row];
        return cell;
    }else if (self.headerViewStatue == couponHeaderViewStyleWithMiddle && tableView == self.leftView){
        couponDropViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponDropViewCell" forIndexPath:indexPath];
        cell.model = self.middleData[indexPath.row];
        return cell;
    }else if (self.headerViewStatue == couponHeaderViewStyleWithMiddle && tableView == self.rightView){
        couponDropViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponDropViewCell" forIndexPath:indexPath];
        cell.model = self.middleData[indexPath.row];
        return cell;
    }else if(self.headerViewStatue == couponHeaderViewStyleWithRight && tableView == self.rightView) {
        couponDropViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponDropViewCell" forIndexPath:indexPath];
        cell.model = self.rightData[indexPath.row];
        return cell;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftView) {
        _currSelectedColum = indexPath.row;
        if (self.delegate && [self.delegate respondsToSelector:@selector(couponHeadViewMethodWith:selectRow:selectedItem:)]) {
            [self.delegate couponHeadViewMethodWith:self.headerViewStatue selectRow:indexPath.row selectedItem:kDefault];
        }
        if (self.isCoupon) {
            if (self.headerViewStatue == couponHeaderViewStyleWithLeft) {
                BHJDropModel *model = self.leftData[indexPath.row];
                [self.tempData removeAllObjects];
                self.tempData = [NSMutableArray arrayWithArray:model.items];
                [self.rightView reloadData];
            }
        }else{
            [self coverClick];
        }
    }
    if (tableView == self.rightView) {
        if (self.headerViewStatue == couponHeaderViewStyleWithRight) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(couponHeadViewMethodWith:selectRow:selectedItem:)]) {
                [self.delegate couponHeadViewMethodWith:self.headerViewStatue selectRow:kDefault selectedItem:indexPath.row];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(couponHeadViewMethodWith:selectRow:selectedItem:)]) {
                [self.delegate couponHeadViewMethodWith:self.headerViewStatue selectRow:_currSelectedColum selectedItem:indexPath.row];
            }
        }
        [self coverClick];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 42.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}















@end
