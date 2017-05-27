//
//  ChangePasswordViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/27.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)setUpUI {
    self.changeButton.layer.cornerRadius = 5;
    self.changeButton.layer.masksToBounds = YES;
    self.changeButton.layer.borderWidth = 2;
    self.changeButton.layer.borderColor = XMColor(104, 173, 128).CGColor;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeButtonClick:(id)sender {
    if (![XMSuperHelper isMobileNumber:self.phoneTextFeild.text]) {
        [Apputil showError:@"请输正确的手机号"];
        return;
    }
    if (self.passwordTextFeild.text.length < 6) {
        [Apputil showError:@"请填写密码，且密码不能小于六位"];
        return;
    }
    
    NSDictionary * dic = @{
                           @"telephone" : self.phoneTextFeild.text,
                           @"newPwd" : self.passwordTextFeild.text
                           };
   
    [WYNetTool GET_Urlstring:changePassword parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:responseObject[@"msg"]];
            return;
        }
        [Apputil showError:@"修改成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } fail:^(id error) {
        [Apputil showError:@"服务器出错"];
    }];
    
}

@end
