//
//  DiscoverViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/24.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "DiscoverViewController.h"
#import <GCDAsyncSocket.h>
#import "WYNetTool.h"
@interface DiscoverViewController ()<GCDAsyncSocketDelegate>
@property (nonatomic,strong)GCDAsyncSocket * socket;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connect];
//    [[GCDSocketManager sharedSocketManager] connectToServer];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    [self connect];
    [self sendMessage];
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


- (void)sendMessage{
    NSString * str = @"2:CDHS100000001:@AGet#";
    [self.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [self.socket readDataWithTimeout:-1 tag:0];
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"已经断开连接!");
    
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
