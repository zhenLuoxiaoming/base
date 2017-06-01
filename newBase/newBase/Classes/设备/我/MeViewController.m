//
//  MeViewController.m
//  newBase
//
//  Created by new-1020 on 2017/6/1.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "MeViewController.h"
#import "OutBandTableViewController.h"
#import "FeedBackViewController.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginOutButtonClick:(id)sender {
    [[LoginTool shareInstance] loginOut];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shebeiClick:(id)sender {
    OutBandTableViewController * vc = [[OutBandTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)adviceButtonClick:(id)sender {
    FeedBackViewController * vc = [[FeedBackViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
