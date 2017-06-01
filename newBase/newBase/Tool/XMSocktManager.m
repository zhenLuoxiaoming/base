//
//  XMSocktManager.m
//  newBase
//
//  Created by new-1020 on 2017/5/31.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "XMSocktManager.h"
#import <GCDAsyncSocket.h>
#import "WYNetTool.h"

@interface XMSocktManager()<GCDAsyncSocketDelegate>
@property (nonatomic,strong) GCDAsyncSocket *socket;
@property (nonatomic,strong) NSString *equipID;
@end

@implementation XMSocktManager

+(instancetype)shareInstance {
    static XMSocktManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMSocktManager alloc]init];
    });
    return manager;
}

-(void)connect {
    NSString *host = @"119.23.45.80";
    int port = 8098;
    self.socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //连接
    NSError *error = nil;
    [self.socket connectToHost:host onPort:port error:&error];
    if(error) {
        NSLog(@"连接错误%@", error);
        return;
    }
    [self.socket readDataWithTimeout:-1 tag:0];
}

- (void)sendMessageWithEquipID:(NSString *)equipID{
    self.equipID = equipID;
    NSString * str =[NSString stringWithFormat: @"1:%@:%@\n",[LoginTool shareInstance].userModel.ID,equipID];
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:2];
    [self.socket readDataWithTimeout:-1 tag:0];
}

//tag : 3
-(void)sendA {
//    2:CDHS100000001:@AGet#
    NSString * str =[NSString stringWithFormat: @"2:%@:@AGet#\n",self.equipID];
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:3];
    [self.socket readDataWithTimeout:-1 tag:0];
}
// 发送各种指令
-(void)sendB {
//    2:CDHS100000001: @B 1 0 0 2#
    NSString * str =[NSString stringWithFormat: @"2:%@:@BGet#\n",self.equipID];
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:4];
    [self.socket readDataWithTimeout:-1 tag:0];
}

-(void)sendDirectorWithA:(int)a b:(int)b c:(int)c d:(int)d {
    NSString * str =[NSString stringWithFormat: @"2:%@: @B %d %d %d %d#\n",self.equipID,a,b,c,d];
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:5];
    [self.socket readDataWithTimeout:-1 tag:0];
}

-(void)sendEWith:(int)i {
    NSString * str =[NSString stringWithFormat: @"2:%@:@E %d#\n",self.equipID,i];
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:6];
    [self.socket readDataWithTimeout:-1 tag:0];
}

-(void)getAMessage {
    NSDictionary * dic = @{
                           @"equipId" :self.equipID //self.data[@"equip_number"]
                           };
    [WYNetTool GET_Urlstring:getA parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:@"请求错误"];
            return ;
        }
        [self.delegate XMSocktManagerGetAWithData:responseObject[@"data"]];
    } fail:^(id error) {
        [Apputil showError:@"网络错误"];
    }];
}

-(void)getBmessage {
    NSDictionary * dic = @{
                           @"equipId" :self.equipID //self.data[@"equip_number"]
                           };
    [WYNetTool GET_Urlstring:getB parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:@"请求错误"];
            return ;
        }
        [self.delegate XMSocktManagerGetBWithData:responseObject[@"data"]];
    } fail:^(id error) {
        [Apputil showError:@"网络错误"];
    }];
}



-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if (tag == 2) {
        [self sendA];
        [self sendB];
    }
    if (tag == 3) {
        [self getAMessage];
    }
    if (tag == 4) {
        [self getAMessage];
        [self getBmessage];
    }
    if (tag == 5 || tag == 6) {
        [self getAMessage];
        [self getBmessage];
    }
    [self.socket readDataWithTimeout:-1 tag:tag];
}


-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"已经断开连接!");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connect];
    });
    [self.socket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接成功");
    [self.socket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket*)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"str = %@", str);
    [self.socket readDataWithTimeout:-1 tag:0];
}





@end
