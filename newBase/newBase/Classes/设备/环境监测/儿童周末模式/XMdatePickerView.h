//
//  XMdatePickerView.h
//  weekend
//
//  Created by new-1020 on 2017/1/12.
//  Copyright © 2017年 MiBang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)chooseDateWithStr:(NSString *)dateStr;

@end

typedef enum{
    DatePickerTypeTime,
    DatePickerTypeDate
}DatePickerType;

@interface XMdatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
+ (instancetype)fastLoginView;
+ (instancetype)fastLoginViewWithType:(DatePickerType)type;
@property (weak, nonatomic) IBOutlet UIButton *CompleteButton;

@property (weak, nonatomic)id<DatePickerViewDelegate>datedelegate;
@property (nonatomic,assign) DatePickerType type;
@end
