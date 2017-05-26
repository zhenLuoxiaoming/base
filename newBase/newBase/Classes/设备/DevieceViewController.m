//
//  DevieceViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/24.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "DevieceViewController.h"
#import "LoginViewController.h"
@interface DevieceViewController ()

@end

@implementation DevieceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLogin];
}

-(void)showLogin {
    LoginViewController * vc = [[LoginViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
