//
//  RegisterViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/26.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "RegisterViewController.h"
#import "JKCountDownButton.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFeild;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpUI];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setUpUI];
}

-(void)setUpUI {
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.borderWidth = 2;
    self.registerButton.layer.borderColor = XMColor(104, 173, 128).CGColor;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}
// 返回
- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 注册
- (IBAction)registerButtonClikc:(id)sender {
    
    if (self.nameTextFiled.text.length < 6) {
        [Apputil showError:@"密码必须大于六位"];
        return;
    }
    if ([self.codeTextFeild.text isEqualToString:@""]) {
        [Apputil showError:@"请输入验证码"];
        return;
    }
    
    NSDictionary * dic = @{
                           @"tel" : self.phoneTextFeild.text,
                           @"password" : self.nameTextFiled.text,
                           @"verify" : @"123456" //self.codeTextFeild.text
                           };
    
    [WYNetTool GET_Urlstring:registerURL parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"errcode"] longValue] != 1) {
            [Apputil showError:responseObject[@"msg"]];
            return;
        }
        [Apputil showError:@"注册成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } fail:^(id error) {
        [Apputil showError:@"网络出错"];
    }];
}
// 获取验证码
- (IBAction)getCodeButtonClikc:(JKCountDownButton *)sender {
    if (![XMSuperHelper isMobileNumber:self.phoneTextFeild.text]) {
        [Apputil showError:@"电话号码格式不正确"];
        return;
    }
    
    NSDictionary * dic = @{
                           @"tel" : self.phoneTextFeild.text
                           };
    [WYNetTool GET_Urlstring:getMessage parameters:dic success:^(id responseObject) {
        if([responseObject[@"errcode"] longValue] == 0) {
            [Apputil showError:@"错误"];
        }else if([responseObject[@"errcode"] longValue] == 1){
            if (responseObject[@"msg"]) {
                [Apputil showError:responseObject[@"msg"]];
                [self countcount:sender];
            }
        }else if([responseObject[@"errcode"] longValue] == 2) {
            [Apputil showError:@"该号码已注册，请直接登陆"];
        }
        
    } fail:^(id error) {
        [Apputil showError:@"网络错误"];
    }];
}

-(void)countcount:(JKCountDownButton *)sender {
    [sender startCountDownWithSecond:60];
    sender.enabled = NO;
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
        return title;
    }];
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
    }];
}

@end
