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
//    [self band];
    [self connect];
//    [[GCDSocketManager sharedSocketManager] connectToServer];
}
-(void)band {
    NSDictionary * dic = @{
                           @"equipId" : @"1",
                           @"userId" : [LoginTool shareInstance].userModel.ID,
                           @"equipNum" : @"CDHS100000002"
                           };
    
    [WYNetTool GET_Urlstring:@"http://119.23.45.80/Demo/public/Index/bindEquipment" parameters:dic success:^(id responseObject) {
        
    } fail:^(id error) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
//    [self connect];
    [self sendMessage];
}

-(void)connect {
    NSString *host = @"119.23.45.80";
    int port = 8098;
    //创建一个socket对象
//    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
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

// 发送数据

- (void)sendMessage{
    NSString * str =[NSString stringWithFormat: @"1:%@:CDHS100000002",[LoginTool shareInstance].userModel.ID];
    [self.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [self.socket readDataWithTimeout:-1 tag:0];
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
