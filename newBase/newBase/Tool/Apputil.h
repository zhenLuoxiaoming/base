//
//  Apputil.h
//  DaDaImage-iPad2.0
//
//  Created by dengchunhua on 16/7/1.
//  Copyright © 2016年 iinda.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apputil : NSObject

/**
 *  国际化(根据key获取字符串)
 */
+(NSString*)LocalizedString:(NSString*)str;
/**
 *  提示消息
 *
 *  @param message 消息文本
 *  @param time    提示框消失间隔时间
 */
+ (void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)time;
/**
 *  提示错误信息
 *
 *  @param errorMessage 错误描述
 */
+ (void)showError:(id)errorMessage;
/**
 *  提示信息，不会自动关闭提示框
 *
 *  @param message 提示信息(nil的时候默认提示  "加载中，请稍后。。。")
 */
+ (void)showMessage:(NSString*) message;
/**
 *  添加全局配置
 *
 *  @param obj 属性
 *  @param key 属性KEY
 */
+(void)NSUserDefAddString:(NSString *) obj key:(NSString *) key;
+(void)NSUserDefAddOject:(id)obj key:(NSString *)key;
/**
 *  获取指定的全局配置属性
 *
 *  @param key 传入key
 *
 *  @return 返回指定key的全局属性
 */
+(NSString *) QueryNSUserDefToKey:(NSString *)key;
+ (void)dismiss;

/**
 *  发布service通知
 *
 *  @param notifiDict 请求需要的数据源
 *  @param name      通知名称
 */
//+(void)ReleaseServiceNotice:(NSDictionary*) notifiDict noticeName:(NSString*) name;

/**
 *  验证邮箱
 *
 *  @param emailStr 传入emailStr
 *
 *  @return 返回YES邮箱正确，否则邮箱格式不正确
 */
+ (BOOL)validateEmailString:(NSString *)emailStr;

/**
 *  验证电话号码格式
 *
 *  @param phoneNumber 传入电话号码
 *
 *  @return 返回YES号码格式正确，否则不正确
 */
+ (BOOL)validatePhoneWithString:(NSString *)phoneNumber;

@end
