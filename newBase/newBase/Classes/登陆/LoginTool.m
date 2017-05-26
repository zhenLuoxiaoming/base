//
//  LoginTool.m
//  newBase
//
//  Created by new-1020 on 2017/5/26.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "LoginTool.h"
#import "LoginViewController.h"
#define userDic @"userDic"

@implementation LoginTool

+(instancetype)shareInstance {
    static LoginTool * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LoginTool alloc]init];
    });
    return manager;
}

-(void)doLoginWithDic:(NSDictionary *)dic {
    UserModel * model = [[UserModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    self.userModel = model;
    NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj == NULL || [obj isEqual:[NSNull null]]) {
            mdic[(NSString*)key] = @"";
        }
    }];
    
    [XMUserDefaults setObject:mdic forKey:userDic];
}

-(BOOL)isLogin {
    if([XMUserDefaults objectForKey:userDic]){
        return YES;
    }else {
        return NO;
    }
}

-(void)loginOut {
    [XMUserDefaults removeObjectForKey:userDic];
}

-(UserModel *)userModel {
    if (_userModel == nil) {
         _userModel = [[UserModel alloc]init];
        if ([self isLogin]) {
            [_userModel setValuesForKeysWithDictionary:[XMUserDefaults objectForKey:userDic]];
        }
    }
    return _userModel;
}

-(void)youMustLoinWithTarget:(UIViewController *)vc Dothis:(void(^)(void))block {
    if (![self isLogin]) {
        LoginViewController * lVC = [[LoginViewController alloc]init];
        [vc presentViewController:lVC animated:YES completion:nil];
        return;
    }else {
        block();
    }
}

@end
