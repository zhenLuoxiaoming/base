//
//  CityChoseView.m
//  newBase
//
//  Created by new-1020 on 2017/5/29.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "CityChoseView.h"

@interface CityChoseView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) UIPickerView * pickerView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign) NSInteger selectedRow;
@property (nonatomic,assign) NSInteger selectedSecondRow;
@end

@implementation CityChoseView

-(UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc]init];
    }
    return _pickerView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Provineces" ofType:@"plist"];
    self.dataArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    UIView * view = [[UIView alloc]init];
    [self addSubview:view];
    view.frame = CGRectMake(0, self.bounds.size.height - SCREEN_HEIGHT / 3  - 40, SCREEN_WIDTH, 40);
    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc]init];
    [view addSubview:btn];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-20);
        make.centerY.equalTo(view);
    }];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.pickerView.frame = CGRectMake(0, self.bounds.size.height - SCREEN_HEIGHT / 3 , SCREEN_WIDTH, SCREEN_HEIGHT / 3);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.selectedRow = 0;
    self.selectedSecondRow = 0;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.showsSelectionIndicator=YES;
    [self addSubview:self.pickerView];
}

-(void)btnClick {
    [self.xDelegate CityChoseViewSelecityCityWithString:self.dataArray[self.selectedRow][@"cities"][self.selectedSecondRow][@"CityName"]];
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataArray.count;
    }
    return [self.dataArray[self.selectedRow][@"cities"] count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 1) {
        return 180;
    }
    return 180;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.selectedRow = row;
        [self.pickerView reloadAllComponents];
    } else {
       
        self.selectedSecondRow = row;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataArray[row][@"ProvinceName"];
    } else {
        return self.dataArray[self.selectedRow][@"cities"][row][@"CityName"];
    }
}

@end
