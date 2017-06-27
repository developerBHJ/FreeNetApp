//
//  OrderDetailViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2017/6/21.
//  Copyright © 2017年 BHJ. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "AddressModel.h"
#import "OrderDetailCell.h"
#import "OrderAddressCell.h"
#import "OrderStoreAddressCell.h"
#import "OrderStorePhoneNumCell.h"
#import "OrderDetailCell_1.h"
#import "OrderHeaderView.h"
#import "OrderDetailBottomView.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BHJCustomViewDelegate>

@property (nonatomic,strong)OrderDetailBottomView *bootomView;
@property (nonatomic,strong)UITableView *orderDetailView;
@property (nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation OrderDetailViewController
#pragma mark - 懒加载
-(UITableView *)orderDetailView{

    if (!_orderDetailView) {
        _orderDetailView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStyleGrouped];
        _orderDetailView.delegate = self;
        _orderDetailView.dataSource = self;
    }
    return _orderDetailView;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    }
    return _dataSource;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBaseUI];
}

#pragma mark - 自定义
-(void)setBaseUI{

    self.navigationItem.title = @"订单详情";
    [self.view addSubview:self.orderDetailView];
    [self.orderDetailView registerNib:[UINib nibWithNibName:@"OrderDetailCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailCell"];
    [self.orderDetailView registerNib:[UINib nibWithNibName:@"OrderAddressCell" bundle:nil] forCellReuseIdentifier:@"OrderAddressCell"];
    [self.orderDetailView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.orderDetailView registerNib:[UINib nibWithNibName:@"OrderStoreAddressCell" bundle:nil] forCellReuseIdentifier:@"OrderStoreAddressCell"];
    [self.orderDetailView registerNib:[UINib nibWithNibName:@"OrderStorePhoneNumCell" bundle:nil] forCellReuseIdentifier:@"OrderStorePhoneNumCell"];
    [self.orderDetailView registerNib:[UINib nibWithNibName:@"OrderDetailCell_1" bundle:nil] forCellReuseIdentifier:@"OrderDetailCell_1"];
    
    self.bootomView = [[OrderDetailBottomView alloc]initWithFrame:CGRectMake(0, self.orderDetailView.bottom, kScreenWidth, 44)];
    self.bootomView.delegate = self;
    self.bootomView.viewStyle = isTwo;
    [self.view addSubview:self.bootomView];
    

}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSource.count + 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0 || (section == self.dataSource.count + 1)) {
        return 2;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.textLabel.text = @"订单编号：201706233329";
            [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
            cell.detailTextLabel.text = @"创建时间：2017-06-23 15:10:22";
            return cell;
        }else{
            OrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAddressCell" forIndexPath:indexPath];
            return cell;
        }
    }else if (indexPath.section == self.dataSource.count + 1){
        OrderDetailCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell_1" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.subTitle.hidden = YES;
            cell.title.text = @"运费";
            cell.priceLabel.text = @"¥8";
            cell.title.textColor = [UIColor blackColor];
            cell.priceLabel.textColor = [UIColor blackColor];
        }else{
            cell.subTitle.hidden = NO;
            cell.title.text = @"共2件商品";
            cell.priceLabel.text = @"¥186";
            cell.title.textColor = [UIColor colorWithHexString:@"#999999"];
            cell.priceLabel.textColor = [UIColor colorWithHexString:@"#e4504b"];
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell" forIndexPath:indexPath];
            return cell;
        }else if (indexPath.row == 1){
            OrderStoreAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderStoreAddressCell" forIndexPath:indexPath];
            return cell;
        }else{
            OrderStorePhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderStorePhoneNumCell" forIndexPath:indexPath];
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return kScreenHeight / 10;
        }
    }
    if (indexPath.section != 0 && indexPath.section != self.dataSource.count + 1) {
        if (indexPath.row == 0) {
            return kScreenHeight / 6;
        }
    }
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section != 0 && section != self.dataSource.count + 1) {
        OrderHeaderView *headView = [[OrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        headView.iconImage.image = [UIImage imageNamed:@"store_icon"];
        headView.storeName.text = @"克拉拉牛排";
        return headView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section != 0 && section != self.dataSource.count + 1) {
        return 30;
    }
    return 1;
}

#pragma mark - BHJCustomViewDelegate
-(void)BHJCustomViewMethodWithButton:(UIButton *)sender{


}
@end
