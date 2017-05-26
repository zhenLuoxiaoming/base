//
//  LoginViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/26.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *centerContentView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)setUpUI{
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    self.centerContentView.layer.borderWidth = 1;
    self.centerContentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loginButton.layer.borderWidth = 2;
    self.loginButton.layer.borderColor = XMColor(104, 173, 128).CGColor;
}

-(void)viewWillAppear:(BOOL)animated {
    self.LogoImageView.layer.cornerRadius = self.LogoImageView.frame.size.height / 2;
    self.LogoImageView.layer.masksToBounds = YES;
    self.LogoImageView.layer.borderWidth = 1;
    self.LogoImageView.layer.borderColor = [UIColor blackColor].CGColor;
}

- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)registerButtonClick:(id)sender {
    RegisterViewController * vc = [[RegisterViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)loginButtonClick:(id)sender {
    if ([self.accountTextFeild.text isEqualToString:@""]) {
        [Apputil showError:@"请填写电话号码"];
        return;
    }
    if ([self.passwordTextFeild.text isEqualToString:@""]) {
        [Apputil showError:@"请填写密码"];
        return;
    }
    [self doLoging];
}

-(void)doLoging {
    NSDictionary * dic = @{
                           @"tel" : self.accountTextFeild.text,
                           @"password" : self.passwordTextFeild.text
                           };
    [WYNetTool GET_Urlstring:LoginUrl parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:responseObject[@"msg"]];
            return ;
        }
        [[LoginTool shareInstance] doLoginWithDic:responseObject[@"data"]];
        [self dismissViewControllerAnimated:YES completion:nil];
    } fail:^(id error) {
        [Apputil showError:@"网络出错"];
    }];
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
