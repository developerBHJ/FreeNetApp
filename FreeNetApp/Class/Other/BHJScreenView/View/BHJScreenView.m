//
//  BHJScreenView.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/3/23.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "BHJScreenView.h"
#import "ClassHeaderView.h"
#import "GCD.h"
#import "StudentInfoCell.h"
#import "screenModel.h"
#import "screenModel.h"
static NSString *infoCellFlag = @"BaseTableViewCell";
static NSString *infoHeadFlag = @"ClassHeaderView";

@interface BHJScreenView ()<UITableViewDataSource, UITableViewDelegate, CustomHeaderFooterViewDelegate>

@property (nonatomic, strong) UITableView     *tableView;

@property (nonatomic) BOOL                     sectionFirstLoad;
@property (nonatomic, weak)   ClassHeaderView *tmpHeadView;

@end

@implementation BHJScreenView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createTableView];
        [self firstLoadDataAnimation];
    }
    return self;
}
#pragma mark - 自定义
- (void)createTableView {
    
    UIButton *bagBtn = [[BHJTools sharedTools]creatButtonWithTitle:nil image:nil selector:@selector(CloseAnimation) Frame:CGRectMake(0, 0, MainScreen_width, MainScreen_height) viewController:nil selectedImage:nil tag:0];
    bagBtn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [self addSubview:bagBtn];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, self.width - 20, self.height - 20)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, backView.width, 44)];
    headLbl.backgroundColor=[UIColor colorWithHexString:@"#f1f1f1"];
    headLbl.textColor=[UIColor blackColor];
    headLbl.text=@"筛选";
    headLbl.textAlignment=NSTextAlignmentCenter;
    [headLbl setFont:[UIFont systemFontOfSize:18]];
    [headLbl addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(5, 5)];
    [backView addSubview:headLbl];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, headLbl.bottom, backView.width, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
    [backView addSubview:line];
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    resetBtn.frame = CGRectMake(10,backView.height - 64, backView.width / 3, 40);
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetBtn setBackgroundColor:[UIColor lightGrayColor]];
    [resetBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.tag = 1000;
    [backView addSubview:resetBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sureBtn.frame = CGRectMake(resetBtn.right + 10, backView.height - 64, backView.width - resetBtn.width - 30, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:HWColor(38, 189, 78, 1)];
    [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag = 1001;
    [backView addSubview:sureBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45,backView.width, backView.height - 104) style:UITableViewStylePlain];
    self.tableView.delegate                       = self;
    self.tableView.dataSource                     = self;
    self.tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    
    [self.tableView registerClass:[StudentInfoCell class] forCellReuseIdentifier:infoCellFlag];
    [self.tableView registerClass:[ClassHeaderView class] forHeaderFooterViewReuseIdentifier:infoHeadFlag];
    
    [backView addSubview:self.tableView];
}

-(void)showScreenViewSetCompletionBlock:(BHJActionBlock)aCompletionBlock{
    
    completionBlock = aCompletionBlock;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    keyWindow.frame = CGRectMake(0, 0, MainScreen_width, MainScreen_height);
    [keyWindow addSubview:self];
}

- (void)firstLoadDataAnimation {
    
    [GCDQueue executeInMainQueue:^{
        
        // Extend sections.
        self.sectionFirstLoad = YES;
        NSIndexSet *indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.dataArr.count)];
        [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        
        [GCDQueue executeInMainQueue:^{
            
            // Extend cells.
            [self customHeaderFooterView:self.tmpHeadView event:nil];
            
        } afterDelaySecs:0.4f];
        
    } afterDelaySecs:0.3f];
}


-(void)CloseAnimation{
    
    NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone,
                    
                    self.tableView.alpha=0;
                    
                    
                    
                    )
completion:^(BOOL finished){
    
    [self.tableView removeFromSuperview];
    [self removeFromSuperview];
}];
}

-(void)buttonClick:(UIButton *)sender{

    [self CloseAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(BHJCustomViewMethodWithButton:)]) {
        [self.delegate BHJCustomViewMethodWithButton:sender];
    }
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    screenModel *model = self.dataArr[section];
    if (model.expend == YES) {
        
        return [model.items count];
        
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.sectionFirstLoad == NO) {
        
        return 0;
    } else {
        
        return [self.dataArr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellFlag];
    screenModel   *classModel   = self.dataArr[indexPath.section];
    cell.data                  = classModel.items[indexPath.row];
    cell.indexPath             = indexPath;
    [cell loadContent];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ClassHeaderView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:infoHeadFlag];
    titleView.delegate         = self;
    titleView.data             = self.dataArr[section];
    titleView.section          = section;
    [titleView loadContent];
    
    if (section == 0) {
        self.tmpHeadView = titleView;
    }
    screenModel *model = self.dataArr[section];
    if (model.expend == YES) {
        [titleView extendStateAnimated:NO];
    } else {
        [titleView normalStateAnimated:NO];
    }
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StudentInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell showSelectedAnimation];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (completionBlock) {
        
        completionBlock((int)indexPath.section,(int)indexPath.row);
    }
}
#pragma mark - CustomHeaderFooterViewDelegate
- (void)customHeaderFooterView:(CustomHeaderFooterView *)customHeaderFooterView event:(id)event {
    
    NSInteger section = customHeaderFooterView.section;
    screenModel *model = self.dataArr[section];
    
    ClassHeaderView *classHeaderView = (ClassHeaderView *)customHeaderFooterView;
    if (model.expend == YES) {
        // 缩回去
        model.expend = NO;
        [classHeaderView normalStateAnimated:YES];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.items.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        // 显示出来
        model.expend = YES;
        [classHeaderView extendStateAnimated:YES];
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.items.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
