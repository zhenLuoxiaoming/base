//
//  UserModel.m
//  newBase
//
//  Created by new-1020 on 2017/5/26.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [NSString stringWithFormat:@"%ld",[value longValue]];
    }
}

@end
