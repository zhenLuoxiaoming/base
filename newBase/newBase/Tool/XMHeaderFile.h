//
//  XMHeaderFile.h
//  xianshi
//
//  Created by new-1020 on 2016/10/18.
//  Copyright © 2016年 dengchunhua. All rights reserved.
//

#ifndef XMHeaderFile_h
#define XMHeaderFile_h
#import "XMSuperHelper.h"
#import "Apputil.h"
#import "WYNetTool.h"
#import "Masonry.h"
#define XMweakSelf __weak typeof(self)weakSelf = self

/************************UI相关*******************************************/

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define XMH(y) ((y/667.0)*([UIScreen mainScreen].bounds.size.height))
#define XMW(x) ((x/375.0)*([UIScreen mainScreen].bounds.size.width))
#define XMKEYWINDOWXM     [UIApplication sharedApplication].keyWindow
#define XMColor(r,g,b) [UIColor colorWithRed:(r) / 256.0 green:(g) / 256.0 blue:(b) / 256.0 alpha:1]
/************************数据处理*******************************************/
//字符串是否为空
#define XMStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define XMArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define XMDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define XMObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
/************************系统、版本、设备相关*************************************/
//APP版本号
#define XMAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define XMSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define XMCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define XMISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define XMISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//获取沙盒Document路径
#define XMDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define XMTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define XMCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

/******************************存粹简写*************************************/
#define XMUserDefaults       [NSUserDefaults standardUserDefaults]
#define XMNotificationCenter [NSNotificationCenter defaultCenter]
//弱引用/强引用
#define XMWeakSelf(type)   __weak typeof(type) weak##type = type;
#define XMStrongSelf(type) __strong typeof(type) type = weak##type;
/******************************调试****************************************/
#define XMGFunc XMGLog(@"%s",__func__)

#ifdef DEBUG // 调试

#define XMGLog(...) NSLog(__VA_ARGS__)

#else // 发布

#define XMGLog(...)

#endif


#endif /* XMHeaderFile_h */
