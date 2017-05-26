//
//  XMSuperHelper.m
//  XMSuperHelper
//
//  Created by new-1020 on 2016/12/6.
//  Copyright © 2016年 new-1020. All rights reserved.
//

#import "XMSuperHelper.h"
#import <sys/utsname.h>
@implementation XMSuperHelper

#pragma -mark: 验证电话号码的正则表达式方法
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1((3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$)";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma -mark: 邮箱判断
+ (BOOL)isEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma -mark: 判断当前设备型号
+(NSString *)CurrentDevice{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //未考虑iPhone3等较老设备，未考虑iPad设备（公司的应用不支持iPad）
    if ([deviceString hasPrefix:@"iPhone3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]||[deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"]||[deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString hasPrefix:@"iPhone6"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    //如果没有匹配直接返回系统提供的类似@iPhone5,3这种型号
    return deviceString;
}
// 随机颜色
+(UIColor *)XMcolorRand {
    // 0
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

+(UIViewController *)XMControllerOfView:(UIView *)theView
{
    for (UIView *view = theView; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

// 给一个view切圆角
+(void)clipCircleFromeView:(UIView *)view withRadius:(CGFloat)radius{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

+(UILabel *)XMLableWithFrame:(CGRect)frame Title:(NSString *)title FontSize:(NSInteger)font {
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.font = [UIFont fontWithName:@"PingFang SC" size:font];
    [label sizeToFit];
    return label;
}

+(UIButton *)XMbuttonWithFrame:(CGRect)frame Tile:(NSString *)title FontSize:(NSInteger)font selector:(SEL)selector Target:(id)target {
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (selector) {
      [button addTarget:target action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
+(CGFloat)LabelHeight:(NSString *)str Width:(NSInteger)width Font:(UIFont *)font{
    CGSize contentStrSize = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName: font}
                                              context:nil].size;
    return contentStrSize.height;
}

@end
