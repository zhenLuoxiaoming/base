//
//  WuranModeViewController.m
//  newBase
//
//  Created by new-1020 on 2017/6/1.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "WuranModeViewController.h"

@interface WuranModeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ugTextFeild;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation WuranModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"污染模式";
    self.ugTextFeild.layer.borderWidth = 1;
    self.ugTextFeild.layer.borderColor = ColorDefault.CGColor;
    self.contentLabel.text = @"根据室内空气质量，自动开启空气进化，让您随时随地处在优质的生活环境当中。";
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
