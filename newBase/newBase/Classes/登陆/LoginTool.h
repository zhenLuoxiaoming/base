//
//  LoginTool.h
//  newBase
//
//  Created by new-1020 on 2017/5/26.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface LoginTool : NSObject
@property (nonatomic,strong) UserModel * userModel;
+(instancetype)shareInstance;
-(void)youMustLoinWithTarget:(UIViewController *)vc Dothis:(void(^)(void))block;
-(void)loginOut;
-(BOOL)isLogin;
-(void)doLoginWithDic:(NSDictionary *)dic;
@end
