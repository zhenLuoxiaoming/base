//
//  XMSuperHelper.h
//  XMSuperHelper
//
//  Created by new-1020 on 2016/12/6.
//  Copyright © 2016年 new-1020. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XMSuperHelper : NSObject
/************************UI相关********************************************/
// 随机颜色
+(UIColor *)XMcolorRand;
//找寻view的控制器
+(UIViewController *)XMControllerOfView:(UIView *)theView;
// 切圆角
+(void)clipCircleFromeView:(UIView *)view withRadius:(CGFloat)radius;
// label
+(UILabel *)XMLableWithFrame:(CGRect)frame Title:(NSString *)title FontSize:(NSInteger)font;
+(UIButton *)XMbuttonWithFrame:(CGRect)frame Tile:(NSString *)title FontSize:(NSInteger)font selector:(SEL)selector Target:(id)target;
// 文字高度
+(CGFloat)LabelHeight:(NSString *)str Width:(NSInteger)width Font:(UIFont *)font;
/************************系统、版本、设备相关**************************************/
// 电话号码正则表达式
+(BOOL)isMobileNumber:(NSString *)mobileNum;
//邮箱正则
+ (BOOL)isEmail:(NSString *)email;
// 当前设备型号
+(NSString *)CurrentDevice;

@end
