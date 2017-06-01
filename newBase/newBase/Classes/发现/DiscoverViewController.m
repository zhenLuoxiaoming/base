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
#import "QianDaoViewController.h"

@interface DiscoverViewController ()<GCDAsyncSocketDelegate>
@property (nonatomic,strong)GCDAsyncSocket * socket;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QianDaoViewController * vc = [[QianDaoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
