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
#import <UIButton+WebCache.h>
#import "UploadViewController.h"

@interface MeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *headimageButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLale;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headimageButton sd_setImageWithURL:[NSURL URLWithString:[LoginTool shareInstance].userModel.user_img] forState:UIControlStateNormal];
    self.nameLale.text = [LoginTool shareInstance].userModel.nickname;
    self.headimageButton.layer.cornerRadius = 45;
    self.headimageButton.layer.masksToBounds = YES;
    self.headimageButton.layer.borderWidth = 1;
    self.headimageButton.layer.borderColor = [UIColor blackColor].CGColor;

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
- (IBAction)headButtonClick:(id)sender {
    UploadViewController * vc = [[UploadViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
