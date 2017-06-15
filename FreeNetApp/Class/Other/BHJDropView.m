//
//  BHJDropView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/1/4.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "BHJDropView.h"
#import "couponHeadView.h"
#import "couponDropViewCell.h"
#import "couponClassCell.h"
#define KBgMaxHeight  MainScreen_height
#define KTableViewMaxHeight 300
#define KTopButtonHeight 44

@implementation BHJIndexPath

+ (instancetype)twIndexPathWithColumn:(NSInteger)column
                                  row:(NSInteger)row
                                 item:(NSInteger)item{
    
    BHJIndexPath *indexPath = [[self alloc] initWithColumn:column row:row item:item];
    return indexPath;
}


- (instancetype)initWithColumn:(NSInteger )column
                           row:(NSInteger )row
                          item:(NSInteger )item{
    if (self = [super init]) {
        self.column = column;
        self.row = row;
        self.item = item;
    }
    return self;
}


@end

static NSString *cellIdent = @"cellIdent";

@interface BHJDropView ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _currSelectColumn;
    NSInteger _currSelectRow;
    NSInteger _currSelectItem;
    
    CGFloat _rightHeight;
    BOOL _isRightOpen;
    BOOL _isLeftOpen;
    BOOL _isThirdOpen;
    
}

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *leftTableView_1;

@property (nonatomic,strong) UITableView *rightTableView;

@property (nonatomic,strong) UIButton *bgButton; //背景

@property (nonatomic,strong) couponHeadView *headView;

@property (nonatomic,strong)UIButton *selectedBtn;
@property (nonatomic,strong)UIImageView *selectedImage;

@end


@implementation BHJDropView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self _setButton];
        [self _initialize];
        [self _setSubViews];
    }
    return self;
}


- (void)_initialize{
    
    _currSelectColumn = 0;
    _currSelectItem = WSNoFound;
    _currSelectRow = WSNoFound;
    _isLeftOpen = NO;
    _isRightOpen = NO;
    _isThirdOpen = NO;
}


- (void)_setButton{
    
    [self addSubview:self.headView];
    UIView *bottomShadow = [[UIView alloc]
                            initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MainScreen_width, 0.5)];
    bottomShadow.backgroundColor = [UIColor colorWithRed:0.468 green:0.485 blue:0.465 alpha:1.000];
    [self addSubview:bottomShadow];
}

- (void)_setSubViews{
    
    [self addSubview:self.bgButton];
    [self.bgButton addSubview:self.leftTableView];
    [self.bgButton addSubview:self.leftTableView_1];
    [self.bgButton addSubview:self.rightTableView];
}


#pragma mark -- public fun --
- (void)reloadLeftTableView{
    
    [self.leftTableView reloadData];
}

- (void)reloadRightTableView;
{
    
    [self.rightTableView reloadData];
}

#pragma mark -- getter --
-(couponHeadView *)headView{
    
    if (!_headView) {
        _headView = [couponHeadView shareCouponHeadView];
        _headView.frame = CGRectMake(0, 0, MainScreen_width, 44);
        [_headView.allBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headView.locationBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headView.sortBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headView.allBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_headView.locationBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_headView.sortBtn layoutButtonWithEdgeInsetsStyle:BHJButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    }
    return _headView;
}

- (UITableView *)leftTableView{
    
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        [_leftTableView registerNib:[UINib nibWithNibName:@"couponClassCell" bundle:nil] forCellReuseIdentifier:@"couponClassCell"];
        _leftTableView.frame = CGRectMake(0, 0, self.bgButton.frame.size.width/2.0, 0);
        _leftTableView.tableFooterView = [[UIView alloc]init];
    }
    return _leftTableView;
}

- (UITableView *)leftTableView_1{
    
    if (!_leftTableView_1) {
        
        _leftTableView_1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView_1.delegate = self;
        _leftTableView_1.dataSource = self;
        [_leftTableView_1 registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        [_leftTableView_1 registerNib:[UINib nibWithNibName:@"couponDropViewCell" bundle:nil] forCellReuseIdentifier:@"couponDropViewCell"];
        _leftTableView_1.frame = CGRectMake( self.bgButton.frame.size.width/2.0, 0 , self.bgButton.frame.size.width / 2.0, 0);
        _leftTableView_1.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        _leftTableView_1.tableFooterView = [[UIView alloc]init];
    }
    return _leftTableView_1;
}

- (UITableView *)rightTableView{
    
    if (!_rightTableView) {
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _rightTableView.frame = CGRectMake(0, 0 , self.bgButton.frame.size.width, 0);
    }
    return _rightTableView;
}

- (UIButton *)bgButton{
    
    if (!_bgButton) {
        
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.frame = CGRectMake(0, KTopButtonHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - KTopButtonHeight);
        [_bgButton addTarget:self action:@selector(bgAction:) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.clipsToBounds = YES;
        
    }
    
    return _bgButton;
}


#pragma mark -- tableViews Change -
- (void)_hiddenLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, self.leftTableView.frame.origin.y, self.leftTableView.frame.size.width, 0);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, self.leftTableView_1.frame.origin.y, self.leftTableView_1.frame.size.width, 0);
}

- (void)_showLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, self.leftTableView.frame.origin.y, self.leftTableView.frame.size.width, KTableViewMaxHeight);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, self.leftTableView_1.frame.origin.y, self.leftTableView_1.frame.size.width, KTableViewMaxHeight);
}

- (void)_showRightTableView{
    
    CGFloat height = MIN(_rightHeight, KTableViewMaxHeight);
    
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, height);
}

- (void)_HiddenRightTableView{
    
    
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, 0);
}

#pragma mark -- Action ----
- (void)buttonAction:(UIButton *)sender{
    
    if (self.headView.allBtn == sender) {
        if (_isLeftOpen) {
            _isLeftOpen = !_isLeftOpen;
            [self bgAction:nil];
            return ;
        }
        [self setSelectedBtnTitleColoreAndImage:@"coupon_0" selectedImageName:@"coupon_0" button:self.headView.allBtn imageView:self.headView.firstImage selectedImage:@"coupon_drop" nomalImage:@"coupon_drop"];
        _currSelectColumn = 0;
        _isLeftOpen = YES;
        _isRightOpen = NO;
        _isThirdOpen = NO;
        [self _HiddenRightTableView];
    }
    if (self.headView.locationBtn == sender) {
        if (_isRightOpen) {
            _isRightOpen = !_isRightOpen;
            [self bgAction:nil];
            return ;
        }
        [self setSelectedBtnTitleColoreAndImage:@"address" selectedImageName:@"address" button:self.headView.locationBtn imageView:self.headView.secondImage selectedImage:@"coupon_drop" nomalImage:@"coupon_drop"];
        _currSelectColumn = 1;
        _isRightOpen = YES;
        _isLeftOpen = NO;
        _isThirdOpen = NO;
        [self _HiddenRightTableView];
        
    }
    if (self.headView.sortBtn == sender) {
        if (_isThirdOpen) {
            _isThirdOpen = !_isThirdOpen;
            [self bgAction:nil];
            return;
        }
        _currSelectColumn = 2;
        _isThirdOpen = YES;
        _isLeftOpen = NO;
        _isRightOpen = NO;
        [self setSelectedBtnTitleColoreAndImage:@"sort" selectedImageName:@"sort_red" button:self.headView.sortBtn imageView:self.headView.thirdImage selectedImage:@"coupon_drop" nomalImage:@"coupon_drop"];
        
        [self _hiddenLeftTableViews];
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, MainScreen_width, MainScreen_height);
    self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, self.bounds.size.height - KTopButtonHeight);
    [UIView animateWithDuration:0.2 animations:^{
        self.bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        
        if (_currSelectColumn == 0 || _currSelectColumn == 1) {
            [self _showLeftTableViews];
        }
        if (_currSelectColumn == 2) {
            [self _showRightTableView];
        }
    } completion:^(BOOL finished) {
        
    }];
}


-(void)setSelectedBtnTitleColoreAndImage:(NSString *)btnNomalImage selectedImageName:(NSString *)btnSelectedImage button:(UIButton *)selectedBtn imageView:(UIImageView *)imageView selectedImage:(NSString *)selectedImage nomalImage:(NSString *)nomalImage{
    
    [selectedBtn setTitleColor:[UIColor colorWithHexString:@"#e4504b"] forState:UIControlStateNormal];
    [selectedBtn setImage:[[UIImage imageNamed:btnSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.selectedBtn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[[UIImage imageNamed:btnNomalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    imageView.image = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.selectedImage.image = [[UIImage imageNamed:nomalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.selectedBtn = selectedBtn;
    self.selectedImage = imageView;
}



- (void)bgAction:(UIButton *)sender{
    
    _isRightOpen = NO;
    _isLeftOpen = NO;
    _isThirdOpen = NO;
    [UIView animateWithDuration:0.2 animations:^{
        
        
        self.bgButton.backgroundColor = [UIColor clearColor];
        [self _hiddenLeftTableViews];
        [self _HiddenRightTableView];
        
    } completion:^(BOOL finished) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, MainScreen_width, KTopButtonHeight);
        self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, 0);
        
        
        
    }];
    
}


#pragma mark -- DataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BHJIndexPath *twIndexPath =[self _getTwIndexPathForNumWithtableView:tableView];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropMenuView:numberWithIndexPath:)]) {
        
        NSInteger count =  [self.dataSource dropMenuView:self numberWithIndexPath:twIndexPath];
        if (twIndexPath.column == 1) {
            _rightHeight = count * 44.0;
        }
        return count;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BHJIndexPath *twIndexPath = [self _getTwIndexPathForCellWithTableView:tableView indexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectedBackgroundView.backgroundColor =  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#696969"];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.backgroundColor = [UIColor clearColor];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropMenuView:titleWithIndexPath:)]) {
        
        cell.textLabel.text =  [self.dataSource dropMenuView:self titleWithIndexPath:twIndexPath];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    if (tableView == self.leftTableView && _currSelectColumn == 0) {
        couponClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponClassCell" forIndexPath:indexPath];
        cell.titleLabel.text =  [self.dataSource dropMenuView:self titleWithIndexPath:twIndexPath];
        cell.rightBtn.titleLabel.text = [self.dataSource dropMenuView:self titleWithIndexPath:twIndexPath];
        return cell;
    }else if (tableView == self.leftTableView && _currSelectColumn == 1){
        
        return cell;
    }
    else if (tableView == self.leftTableView_1 && _currSelectColumn == 0){
        couponDropViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponDropViewCell" forIndexPath:indexPath];
        return cell;
    }else if (tableView == self.leftTableView_1 && _currSelectColumn == 1){
        
        return cell;
    }
    return cell;
}

#pragma mark - tableView delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTableView) {
        _currSelectRow = indexPath.row;
        _currSelectItem = WSNoFound;
        [self.leftTableView_1 reloadData];
    }
    if (tableView == self.leftTableView_1) {
        _currSelectItem = indexPath.row;
    }
    if (self.rightTableView == tableView) {
        [self bgAction:nil];
    }
}



- (BHJIndexPath *)_getTwIndexPathForNumWithtableView:(UITableView *)tableView{
    
    
    if (tableView == self.leftTableView) {
        
        return  [BHJIndexPath twIndexPathWithColumn:_currSelectColumn row:WSNoFound item:WSNoFound];
        
    }
    if (tableView == self.leftTableView_1 && _currSelectRow != WSNoFound) {
        
        return [BHJIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:WSNoFound];
    }
    
    if (tableView == self.rightTableView) {
        
        return [BHJIndexPath twIndexPathWithColumn:1 row:WSNoFound item:WSNoFound ];
    }
    return  0;
}


- (BHJIndexPath *)_getTwIndexPathForCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.leftTableView) {
        
        return  [BHJIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound];
        
    }
    
    if (tableView == self.leftTableView_1) {
        
        return [BHJIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:indexPath.row];
    }
    
    
    if (tableView == self.rightTableView) {
        
        return [BHJIndexPath twIndexPathWithColumn:1 row:indexPath.row item:WSNoFound];
    }
    
    
    return  [BHJIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}



@end

