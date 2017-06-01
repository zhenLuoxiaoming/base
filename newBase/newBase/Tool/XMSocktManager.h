//
//  XMSocktManager.h
//  newBase
//
//  Created by new-1020 on 2017/5/31.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMSocktManagerDelegate <NSObject>

-(void)XMSocktManagerGetAWithData:(NSDictionary *)data;
-(void)XMSocktManagerGetBWithData:(NSDictionary *)data;

@end

@interface XMSocktManager : NSObject
+(instancetype)shareInstance;

@property (nonatomic,weak) id<XMSocktManagerDelegate> delegate;

- (void)sendMessageWithEquipID:(NSString *)equipID;
-(void)connect;
-(void)getAMessage;

-(void)sendA;
-(void)sendB;

-(void)sendDirectorWithA:(int)a b:(int)b c:(int)c d:(int)d;
-(void)sendEWith:(int)i;
@end
