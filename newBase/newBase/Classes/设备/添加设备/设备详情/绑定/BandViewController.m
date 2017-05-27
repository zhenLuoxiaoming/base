//
//  BandViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/27.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "BandViewController.h"

@interface BandViewController ()
@property (weak, nonatomic) IBOutlet UITextField *CodeTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *bandbutton;

@end

@implementation BandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI {
    self.bandbutton.layer.cornerRadius = 5;
    self.bandbutton.layer.masksToBounds = YES;
    self.bandbutton.layer.borderWidth = 2;
    self.bandbutton.layer.borderColor = XMColor(104, 173, 128).CGColor;
}
-(void)band {
    if ([self.CodeTextFeild.text isEqualToString:@""]) {
        [Apputil showError:@"请输入设备编号"];
        return;
    }
    
    [Apputil showMessage:@"绑定中"];
    NSDictionary * dic = @{
                           @"equipId" : self.equipId,
                           @"userId" : [LoginTool shareInstance].userModel.ID,
                           @"equipNum" : self.CodeTextFeild.text
                           };
    
    [WYNetTool GET_Urlstring:@"http://119.23.45.80/Demo/public/Index/bindEquipment" parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:responseObject[@"msg"]];
            return ;
        }
            [Apputil showError:@"绑定成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(id error) {
        [Apputil dismiss];
        [Apputil showError:@"网络出错"];
    }];
}

- (IBAction)bandButtonClick:(id)sender {
    [self band];
}


@end
