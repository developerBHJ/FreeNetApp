//
//  ZYLPickerView.m
//  PickerView
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import "ZYLPickerView.h"



@implementation ZYLPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
        
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [self.cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.cancelBtn];
        
        self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 5, 40, 30)];
        
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.confirmBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [self.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.confirmBtn];
        
        self.lbProCityName = [[UILabel alloc] initWithFrame:CGRectMake(self.cancelBtn.frame.origin.x + self.cancelBtn.frame.size.width, 5, self.confirmBtn.frame.origin.x - self.cancelBtn.frame.size.width - self.cancelBtn.frame.origin.x, 30)];
        
        self.lbProCityName.textColor = [UIColor redColor];
        
        self.lbProCityName.text = @"请选择地点";
        
        self.lbProCityName.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.lbProCityName];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.lbProCityName.frame.origin.y + self.lbProCityName.frame.size.height, self.frame.size.width, self.frame.size.height - self.lbProCityName.frame.size.height)];
        
        self.pickerView.delegate = self;
        
        self.pickerView.dataSource = self;
        
        [self addSubview:self.pickerView];
        
        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
        
        
    }
    
    return self;
    
}

#pragma mark - 取消按钮点击事件
-(void)cancelBtnClick{
    
    self.SelectBlock(nil);

    [self disMiss];
    
}

#pragma mark - 确定按钮点击事件
-(void)confirmBtnClick{
    
    self.SelectBlock(self.proCityName);
    
    [self disMiss];

}

#pragma mark - 删除视图
-(void)disMiss{

    [self removeFromSuperview];

}

#pragma mark -懒加载
-(NSArray *)citiesArray{
    if (!_citiesArray) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
        NSMutableArray *nmArray = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            [nmArray addObject:[city citiesWithDic:dic]];
        }
        _citiesArray = nmArray;
    }
    return _citiesArray;
}

#pragma mark - 实现 pickerview 协议
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.citiesArray.count;
        
    }else{
        

        NSInteger seleProIndx = [pickerView selectedRowInComponent:0];
        
        city * selePro = self.citiesArray[seleProIndx];
      
        self.selecletPro = selePro;
       
        return selePro.cities.count;
        
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        
        city * city = self.citiesArray[row];
        
        return city.name;
        
        }else{

        return self.selecletPro.cities[row];
            
        }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        [pickerView reloadComponent:1];
        
    }

    NSInteger selePro = [pickerView selectedRowInComponent:0];
    NSInteger seleCity = [pickerView selectedRowInComponent:1];
    
    city * pro = self.citiesArray[selePro];

    NSString * city = self.selecletPro.cities[seleCity];
    
    self.proCityName = [NSString stringWithFormat:@"%@ %@",pro.name,city];
    
    self.lbProCityName.text = self.proCityName;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
