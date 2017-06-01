//
//  WeekModelViewControolerViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/31.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "WeekModelViewControolerViewController.h"
#import "XMdatePickerView.h"
@interface WeekModelViewControolerViewController ()<DatePickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *oepnButton;
@property (weak, nonatomic) IBOutlet UIButton *colseButton;
@property (nonatomic,strong) XMdatePickerView *pickView;
@property (weak, nonatomic) IBOutlet UIButton *sleepButton;
@property (weak, nonatomic) IBOutlet UIButton *getUpButton;
@property (nonatomic,weak) UIButton *currentButton;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end

@implementation WeekModelViewControolerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.title isEqualToString:@"儿童模式"]) {
        
    }else {
        self.headImageView.image = [UIImage imageNamed:@"zhoumomoshi"];
    }
    [self clipButton:self.oepnButton];
    [self clipButton:self.colseButton];

}

-(void)clipButton:(UIButton *)btn {
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = XMColor(104, 173, 128).CGColor;
}

- (void)chooseDateWithStr:(NSString *)dateStr {
    [self.pickView removeFromSuperview];
    [self.currentButton setTitle:dateStr forState:UIControlStateNormal];
}

- (IBAction)timeButtonClick:(UIButton *)sender {
    self.pickView = [XMdatePickerView fastLoginViewWithType:DatePickerTypeTime];
    self.currentButton = sender;
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.datedelegate = self;
    [self.view addSubview:self.pickView];
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@200);
    }];
}


@end
