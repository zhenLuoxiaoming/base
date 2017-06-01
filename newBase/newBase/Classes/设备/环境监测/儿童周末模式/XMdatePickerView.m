//
//  XMdatePickerView.m
//  weekend
//
//  Created by new-1020 on 2017/1/12.
//  Copyright © 2017年 MiBang. All rights reserved.
//

#import "XMdatePickerView.h"

@interface XMdatePickerView ()
@property(nonatomic,assign) BOOL isType;
@end

@implementation XMdatePickerView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.5;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    self.datePicker.locale = locale;
    self.datePicker.minimumDate = [NSDate date];
    
//    [self.datePicker addTarget:self action:@selector(OkbuttonClick:) forControlEvents:UIControlEventValueChanged];
}

+ (instancetype)fastLoginView {
    // 注册xib
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)fastLoginViewWithType:(DatePickerType)type{
    XMdatePickerView * pc = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    pc.type = type;
    if (pc.type == DatePickerTypeDate) {
        pc.datePicker.datePickerMode = UIDatePickerModeDate;
    }else  if(pc.type == DatePickerTypeTime){
        pc.datePicker.datePickerMode = UIDatePickerModeTime;
    }
    pc.isType = YES;
    return pc;
}

-(void)setType:(DatePickerType)type {
    _type = type;
    if (_type == DatePickerTypeDate) {
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.minimumDate = [NSDate date];
    }else  if(_type == DatePickerTypeTime){
        self.datePicker.datePickerMode = UIDatePickerModeTime;
        self.datePicker.minimumDate = [NSDate distantPast];
    }
}

- (IBAction)OkbuttonClick:(UIButton *)sender {
    NSDate* date = self.datePicker.date;
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    if (self.isType) {
        if (self.type == DatePickerTypeTime) {
            [pickerFormatter setDateFormat:@"HH:mm"];
        }else if(self.type == DatePickerTypeDate) {
            [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
        }
    }else{
         [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
   
   
    NSString *dateString = [pickerFormatter stringFromDate:date];
    [self.datedelegate chooseDateWithStr:dateString];
   
}



@end
