//
//  Apputil.m
//  DaDaImage-iPad2.0
//
//  Created by dengchunhua on 16/7/1.
//  Copyright © 2016年 iinda.com. All rights reserved.
//

#import "Apputil.h"
#import "SVProgressHUD.h"
//#import "NetWorkingUtil.h"
//#import "DCHHeaderFile.h"
#import "AppDelegate.h"

@implementation Apputil

+(NSString *)LocalizedString:(NSString *)str
{
    return NSLocalizedString(str, @"");
}

+ (void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)time
{
    
    [SVProgressHUD showProgress:1 status:message];
    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:time? time : 0.5];
}

+ (void)showError:(id)errorMessage {
    if([errorMessage isKindOfClass:[NSError class]])
    {
        [SVProgressHUD showImage:nil status:LocalizedString([errorMessage localizedDescription])];
    }else{
//            //延迟一定的时间触发事件（延迟提交）
//            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC);
//            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                [(AppDelegate *)[UIApplication sharedApplication].delegate showWindowHome:LOGIN_OUT];
//            });
            [SVProgressHUD showImage:nil status:errorMessage];
    }
   
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:3];
}

+ (void)showMessage:(NSString*) message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus: message ? message : LocalizedString(@"Loading")];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

+(void)NSUserDefAddString:(NSString *)obj key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)NSUserDefAddOject:(id)obj key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *) QueryNSUserDefToKey:(NSString *)key
{
    NSString* value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return value;
}

//+ (void)ReleaseServiceNotice:(NSDictionary *)notifiDict noticeName:(NSString *)name
//{
//    if ([Apputil checkNewWorkStatus]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:name object:notifiDict];
//    }else{
//        [Apputil showError:@"没有网络"];
//    }
//}

+ (BOOL)validateEmailString:(NSString *)emailStr
{
//    BOOL stricterFilter = NO;
//    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
//    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
//    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:emailStr];
    //去掉字符串左右两边空格
    emailStr = [emailStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL bl = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",_FORM_STRING_EMAIL__] evaluateWithObject:emailStr];
    return bl;
}

+ (BOOL)validatePhoneWithString:(NSString *)phoneNumber
{
//    NSString *phoneRegex = @"^[0-9]{6,14}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
//    return [phoneTest evaluateWithObject:phoneNumber];
    
    if (phoneNumber.length != 11)
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
    NSString *MOBILE = @"^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)";
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
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

@end
